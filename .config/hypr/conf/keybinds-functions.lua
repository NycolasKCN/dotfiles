local mainMod = "Super_L"
local PIN_TAG = "pin_nofocus"
local OPACITY_TAG = "pin_opacity"

local NOTIFY_ICONS = {
	ok = "emblem-default",
	info = "dialog-information",
	warning = "dialog-warning",
}

local MAX_ZOOM = 3.5
local MIN_ZOOM = 1
local ZOOM_TOGGLE_FACTOR = 1.5

--- Binds a key combination prefixed with `mainMod`.
--- Example: `bindm("Q", dispatcher)` binds `mainMod + Q`.
---@param keys string Key(s) appended to `mainMod` (e.g. "Q", "SHIFT + Q")
---@param dispatcher any Dispatcher to run, built with `hl.dsp.*`
---@param flags? table Optional bind flags (e.g. `{ repeating = true }`); defaults to `{}`
---@return nil
local function bindm(keys, dispatcher, flags)
	keys = mainMod .. "+" .. keys
	flags = flags or {}

	hl.bind(keys, dispatcher, flags)
end

--- Binds `mainMod + keys` to run a shell command.
--- Shortcut for `bindm` with `hl.dsp.exec_cmd`.
---@param keys string Key(s) appended to `mainMod`
---@param command string Shell command to execute
---@param flags? table Optional bind flags; defaults to `{}`
---@return nil
local function bindm_exec(keys, command, flags)
	bindm(keys, hl.dsp.exec_cmd(command), flags)
end

--- Binds a key combination (WITHOUT `mainMod`) to run a shell command.
--- Use this for keys that must be used on their own, such as media keys
--- or mouse buttons.
---@param keys string Full key combination (e.g. "XF86AudioMute", "mouse:276")
---@param command string Shell command to execute
---@param flags? table Optional bind flags; defaults to `{}`
---@return nil
local function bind_exec(keys, command, flags)
	flags = flags or {}

	hl.bind(keys, hl.dsp.exec_cmd(command), flags)
end

--- Quotes a string so it can be safely passed as a single shell argument.
--- Wraps the string in single quotes and escapes any single quote inside it
--- using the `'\''` idiom.
--- Example: `it's` -> `'it'\''s'`
---@param s string String to quote
---@return string quoted The shell-safe string
local function shell_quote(s)
	return "'" .. (s:gsub("'", "'\\''")) .. "'"
end

--- Shows a desktop notification through `notify-send`.
--- Notifications share the `hypr-pin` synchronous hint, so a new one replaces
--- the previous one instead of stacking. The notification lasts 2 seconds.
---@param text string Message to display
---@param level? "ok"|"info"|"warning" Controls the icon (via `NOTIFY_ICONS`) and urgency
--- (`warning` -> normal urgency, others -> low). Defaults to `"ok"`.
---@return nil
local function notify(text, level)
	level = level or "ok"
	local urgency = level == "warning" and "normal" or "low"

	local cmd = table.concat({
		"notify-send",
		"-a Hyprland",
		"-t 2000",
		"-u " .. urgency,
		"-i " .. NOTIFY_ICONS[level],
		"-h string:x-canonical-private-synchronous:hypr-pin",
		shell_quote(text),
	}, " ")

	hl.dispatch(hl.dsp.exec_cmd(cmd))
end

--- Changes the cursor zoom level (`cursor.zoom_factor`).
--- - With `offset`: adds it to the current zoom (negative values zoom out).
--- - Without `offset`: toggles between `MIN_ZOOM` (no zoom) and
---   `ZOOM_TOGGLE_FACTOR`.
--- The result is always clamped to the `[MIN_ZOOM, MAX_ZOOM]` range.
---@param offset? number Amount to add to the current zoom factor
---@return nil
local function zoom(offset)
	local current = hl.get_config("cursor.zoom_factor")
	if offset ~= nil then
		current = current + offset
	elseif current ~= MIN_ZOOM then
		current = MIN_ZOOM
	else
		current = ZOOM_TOGGLE_FACTOR
	end
	current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
	hl.config({ cursor = { zoom_factor = current } })
end

--- Moves focus to the next window of the opposite kind: from a floating
--- window to a tiled one, and from a tiled window to a floating one.
--- Does nothing if there is no active window.
---@return nil
local function toggle_float_focus()
	local window = hl.get_active_window()
	if not window then
		return
	end
	hl.dispatch(hl.dsp.window.cycle_next({
		floating = not window.floating,
		tiled = window.floating,
	}))
end

--- Floats the window if it is tiled. Does nothing if it is already floating.
---@param window table Window to float
---@return boolean changed `true` if the window was tiled and had to be floated
local function ensure_floating(window)
	if window.floating then
		return false
	end
	hl.dispatch(hl.dsp.window.float({ action = "set", window = window }))
	return true
end

--- Puts a window in the "pinned + no_focus" state:
--- floats it (if needed), tags it with `PIN_TAG`, pins it, and sets the
--- `no_focus` property so it never takes focus.
--- Reverted by `unmark_pin_nofocus`.
---@param window table Window to mark
---@return boolean was_tiled `true` if the window had to be floated first
local function mark_pin_nofocus(window)
	local was_tiled = ensure_floating(window)

	hl.dispatch(hl.dsp.window.tag({ tag = "+" .. PIN_TAG, window = window }))
	hl.dispatch(hl.dsp.window.tag({ tag = "+" .. OPACITY_TAG, window = window }))
	if not window.pinned then
		hl.dispatch(hl.dsp.window.pin({ window = window }))
	end
	hl.dispatch(hl.dsp.window.set_prop({ prop = "no_focus", value = "1", window = window }))

	return was_tiled
end

--- Reverts `mark_pin_nofocus`: unsets `no_focus`, unpins the window and
--- removes `PIN_TAG`. The window stays floating (it is not sent back to tiling).
---@param window table Window to restore
---@return nil
local function unmark_pin_nofocus(window)
	hl.dispatch(hl.dsp.window.set_prop({ prop = "no_focus", value = "unset", window = window }))
	if window.pinned then
		hl.dispatch(hl.dsp.window.pin({ window = window }))
	end
	hl.dispatch(hl.dsp.window.tag({ tag = "-" .. PIN_TAG, window = window }))
	hl.dispatch(hl.dsp.window.tag({ tag = "-" .. OPACITY_TAG, window = window }))
end

--- Toggles the "pinned + no_focus" state (bound to `mouse:276`).
--- - If any window is already marked with `PIN_TAG`, restores ALL of them.
--- - Otherwise, marks the active window (floating it first if needed).
--- Refuses to act on fullscreen windows and shows a notification instead.
---@return nil
local function toggle_pin_nofocus()
	-- If any window is already marked, this press restores all of them
	local marked = hl.get_windows({ tag = PIN_TAG })
	if #marked > 0 then
		for _, w in ipairs(marked) do
			unmark_pin_nofocus(w)
		end
		notify("Pin + no_focus: disabled", "info")
		return
	end

	local window = hl.get_active_window()
	if not window then
		return
	end

	if window.fullscreen ~= 0 then
		notify("Exit fullscreen first", "warning")
		return
	end

	local was_tiled = mark_pin_nofocus(window)
	notify(was_tiled and "Floated + pinned (no focus)" or "Pinned (no focus)")
end

--- Toggles pinning on the active window.
--- - If pinned: unpins it.
--- - If not pinned: floats it (if needed) and pins it.
--- Refuses to act on fullscreen windows and shows a notification instead.
--- Does nothing if there is no active window.
---@return nil
local function toggle_pin()
	local window = hl.get_active_window()
	if not window then
		return
	end

	if window.fullscreen ~= 0 then
		return
	end

	if window.pinned then
    hl.dispatch(hl.dsp.window.tag({ tag = "-" .. OPACITY_TAG, window = window }))
		hl.dispatch(hl.dsp.window.pin({ window = window }))
		notify("Window unpinned", "info")
		return
	end

	local was_tiled = ensure_floating(window)
	hl.dispatch(hl.dsp.window.pin({ window = window }))
	hl.dispatch(hl.dsp.window.tag({ tag = "+" .. OPACITY_TAG, window = window }))
	notify(was_tiled and "Floated + pinned" or "Window pinned")
end

return {
	bindm = bindm,
	bindm_exec = bindm_exec,
	bind_exec = bind_exec,
	shell_quote = shell_quote,
	notify = notify,
	zoom = zoom,
	toggle_float_focus = toggle_float_focus,
	ensure_floating = ensure_floating,
	mark_pin_nofocus = mark_pin_nofocus,
	unmark_pin_nofocus = unmark_pin_nofocus,
	toggle_pin_nofocus = toggle_pin_nofocus,
	toggle_pin = toggle_pin,
}
