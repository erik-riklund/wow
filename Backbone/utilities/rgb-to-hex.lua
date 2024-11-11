--[[~ Module: ? ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
---@param r number
---@param g number
---@param b number
---
backbone.utilities.rgbToHex = function(r, g, b)
  return string.format('%02X%02X%02X', 255 * r, 255 * g, 255 * b) --
end
