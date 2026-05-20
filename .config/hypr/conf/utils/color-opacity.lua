local utils = {}

---@param color string the color on format 'rgba(r,g,b,a)'
---@param alpha number new alpha color
---@return string string the rgba color with new alpha
function utils.colorWithOpacity(color, alpha)
  local result = color:gsub("rgba%((%d+),(%d+),(%d+),[^)]+%)", function(r, g, b)
    return string.format("rgba(%s,%s,%s,%.2f)", r, g, b, alpha)
  end)
  return result
end

return utils;
