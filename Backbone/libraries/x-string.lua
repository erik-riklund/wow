--[[~ Library: String Utilities ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/28

  This library provides utility functions for handling strings. These functions allow checking 
  for specific prefixes and suffixes in strings, as well as extracting substrings based on a 
  defined character and occurrence.

  Features:
  
  - Check if a string starts with a given prefix.
  - Check if a string ends with a given suffix.
  - Extract substrings after a specific character occurrence.

]]

_G.xstring = {}

---
--- hasPrefix()
---
--- This function checks whether the given `target` string starts with one of the specified prefixes. 
--- The `prefix` can be either a single string or an array of strings. If the target string matches 
--- the beginning of any prefix, the function returns true.
---
---@param target  string "The string to check for the prefix."
---@param prefix  string | string[] "The prefix or list of prefixes to check."
---
---@return boolean "True if the target starts with one of the given prefixes, false otherwise."
---
xstring.hasPrefix = function(target, prefix)
  if type(target) ~= 'string' then
    throw('Invalid target. Expected a string.')
  end

  if type(prefix) == 'string' then
    prefix = { prefix } -- convert a single prefix to an array.
  end

  -- Loop through each prefix and check if the target string starts with it. If a match is found, 
  -- return true. If no matches are found, return false after the loop.

  for index, value in ipairs(prefix) do
    if target:sub(1, string.len(value)) == value then
      return true -- Match found.
    end
  end

  return false
end

---
--- hasSuffix()
---
--- This function checks whether the given `target` string ends with one of the specified suffixes. 
--- The `suffix` can be either a single string or an array of strings. If the target string matches 
--- the end of any suffix, the function returns true.
---
---@param target string "The string to check for the suffix."
---@param suffix string | string[] "The suffix or list of suffixes to check."
---@return boolean "True if the target ends with one of the given suffixes, false otherwise."
---
xstring.hasSuffix = function(target, suffix)
  if type(target) ~= 'string' then
    throw('Invalid target. Expected a string.')
  end

  -- If the suffix is a single string, convert it into an array for uniform handling.

  if type(suffix) == 'string' then
    suffix = { suffix } -- convert a single suffix to an array.
  end

  local targetLength = string.len(target)
  
  -- Loop through each suffix and check if the target string ends with it. If a match is found, 
  -- return true. If no matches are found, return false after the loop.

  for index, value in ipairs(suffix) do
    local suffixLength = string.len(value)

    if suffixLength <= targetLength then
      if string.sub(target, targetLength - suffixLength + 1) == value then
        return true -- Match found.
      end
    end
  end

  return false
end

---
--- getSubstringAfter()
---
--- This function retrieves the substring of the `target` string that occurs after the specified 
--- character. The search for the character can be limited by the optional `occurrence` parameter, 
--- which specifies how many occurrences of the character to skip before extracting the substring.
---
---@param target     string "The string to extract the substring from."
---@param character  string "The character after which to start extracting the substring."
---@param occurence? number "(optional) The number of occurrences of the character to skip (default = 1)."
---
---@return string "The substring after the specified character occurrence."
---
xstring.getSubstringAfter = function(target, character, occurence)
  if type(occurence) ~= 'number' then
    occurence = 1 -- Default to the first occurrence.
  end

  if type(character) ~= 'string' or string.len(character) > 1 then
    throw('Invalid character, expected a single character string.')
  end

  if type(target) ~= 'string' then
    throw('Invalid target, expected a string.')
  end

  ---@type string[]
  local result = {}
  local targetLength = string.len(target)
  local charactersFound = 0

  -- Loop through each character in the target string. Once the specified number of occurrences 
  -- of the character have been found, begin storing the remaining characters in the result table.

  for i = 1, targetLength do
    local currentCharacter = string.sub(target, i, i)

    if charactersFound >= occurence then
      table.insert(result, currentCharacter)
    end

    if currentCharacter == character then
      charactersFound = charactersFound + 1
    end
  end

  return table.concat(result)
end
