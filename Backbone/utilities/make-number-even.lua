--[[~ Utility: Even Number Creator ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: 2024/10/21
]]

---
--- Adjusts a number to the nearest even number.
--- Rounds upwards by default unless specified otherwise.
---
---@param number number
---@param upwards? boolean
---
backbone.utilities.makeNumberEven = function(number, upwards)
  return (number % 2 == 0 and number) or (number + ((upwards ~= false and 1) or -1))
end
