--[[~ Utility: Substring After ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  Provides a utility to extract the remaining portion of a string
  after the nth occurrence of the specified search string.

]]

---
--- Returns the remaining portion of the target string after
--- the nth occurrence of the specified search string.
---
---@param target string
---@param searchString string
---@param occurence? number
---
backbone.utilities.getSubstringAfter = function(target, searchString, occurence)
  if type(occurence) ~= 'number' then occurence = 1 end
  return table.remove { searchString:split(target, occurence + 1) }
end
