--[[~ Module: ? ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

]]

---
--- ?
---
---@param target string
---@param searchString string
---@param occurence? number
---
utilities.getSubstringAfter = function(target, searchString, occurence)
  if type(occurence) ~= 'number' then occurence = 1 end
  return table.remove { searchString:split(target, occurence + 1) }
end
