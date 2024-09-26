--[[~ Library: String Utilities (xstring) ~

  Version: 1.0.0 | Updated: 2024/09/25

  A library providing string manipulation utilities, including functions
  for checking string prefixes and suffixes.

  Features:
  
  - Check if a string starts with a specific prefix.
  - Check if a string ends with a specific suffix.

]]

_G.xstring = {}

---
--- Checks if the target string starts with the specified prefix.
---
---@param target  string  "The string to check."
---@param prefix  string  "The prefix to match."
---@return boolean "Returns true if the target starts with the prefix, otherwise false."
---
xstring.hasPrefix = function(target, prefix)
  return (target:sub(1, prefix:len()) == prefix)
end

---
--- Checks if the target string ends with the specified suffix.
---
---@param target string "The string to check."
---@param suffix string "The suffix to match."
---@return boolean "Returns true if the target ends with the suffix, otherwise false."
---
xstring.hasSuffix = function(target, suffix)
  local targetLength = #target
  local suffixLength = #suffix

  if suffixLength > targetLength then return false end
  return (suffix == target:sub(targetLength - suffixLength + 1))
end

---
--- ?
---
---
---
xstring.getSubstringAfter = function()
  -- todo: implement this!
end
