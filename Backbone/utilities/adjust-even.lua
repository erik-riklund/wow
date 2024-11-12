--[[~ Number Adjustment ~
  Updated: 2024/10/21 | Author(s): Erik Riklund (Gopher)
]]

---
--- Adjusts a number to the nearest even number.
--- Rounds upwards by default unless specified otherwise.
---
---@param number number
---@param upwards? boolean
---
backbone.utilities.adjustToEven = function(number, upwards)
  return (number % 2 == 0 and number) or (number + ((upwards ~= false and 1) or -1))
end
