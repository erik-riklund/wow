--[[~ String Manipulation ~
  Updated: 2024/10/25 | Author(s): Erik Riklund (Gopher)
]]

---
--- Capitalizes the first letter of the given string.
---
---@param target string
---
backbone.utilities.capitalizeString = function(target)
  local firstLetter = string.sub(target, 1, 1)
  return string.upper(firstLetter) .. string.sub(target, 2, #target)
end
