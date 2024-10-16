--[[~ Module: ? ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: ?

]]

---
--- ?
---
---@param number number
---@param upwards? boolean
backbone.utilities.makeNumberEven = function(number, upwards)
  return (number % 2 == 0 and number) or (number + ((upwards ~= false and 1) or -1))
end
