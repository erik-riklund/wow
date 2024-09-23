--[[

  Project: Backbone (framework)
  Library: ?
  Version: 1.0.0

  Author(s): Erik Riklund
  Created: 2024/09/22 | Updated: 2024/09/23

  ?

]]

---
--- ?
---
_G.xstring = {
  ---
  --- Checks if the given string starts with the specified prefix. This utility is
  --- useful for quickly determining whether a string begins with a particular sequence
  --- of characters, without manually slicing or looping through the string.
  ---
  ---@param target  string  "The string to check."
  ---@param prefix  string  "The prefix to check for at the beginning of the target string."
  ---
  hasPrefix = function(target, prefix)
    --
    -- Compare the start of the target string with the prefix by slicing the string
    -- to the length of the prefix and checking for equality.
    
    return (target:sub(1, prefix:len()) == prefix)
  end,

  ---
  --- Checks if the given string ends with the specified suffix. This utility ensures
  --- that suffixes can be easily checked without manually slicing the string.
  --- It is designed to be efficient by returning early if the suffix is longer
  --- than the target string.
  ---
  ---@param target string "The string to check."
  ---@param suffix string "The suffix to check for at the end of the target string."
  ---
  hasSuffix = function(target, suffix)
    local targetLength = #target
    local suffixLength = #suffix

    -- If the suffix is longer than the target string, it cannot be a valid suffix.
    if suffixLength > targetLength then return false end

    -- Compares the end of the target string with the suffix.
    return (suffix == target:sub(targetLength - suffixLength + 1))
  end,
}
