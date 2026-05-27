local Host = {}

---@type string?
local HOST = os.getenv("HOST")

---@return boolean
function Host.isDesktop()
  return HOST == "nyc-desktop"
end

---@return boolean
function Host.isLaptop()
  return HOST == "laptop"
end

return Host
