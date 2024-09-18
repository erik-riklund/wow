--
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
---
--- Returns the portion of the string that follows the nth occurrence of a specified character.
--- This is useful when you need to extract a part of a string based on a recurring delimiter.
--- For example, it can help in parsing paths or structured data formats.
---
--- @param target     string  The string to search within. This should be the source string where the search is performed.
--- @param char       string  The character to search for. The function expects this to be a single character that acts as a delimiter.
--- @param occurence? number  The occurrence of the character after which to extract the substring. If omitted, the function defaults to the first occurrence.
---
--- @return string "The substring that comes after the specified occurrence of the character, or an empty string if the occurrence is not found."
---
_G.getSubstringAfter = function(target, char, occurence)
  -- validate the input types to prevent unexpected behavior.

  if type(target) ~= 'string' then
    throwTypeError('target', 'string', type(target))
  end

  if type(char) ~= 'string' or #char > 1 then
    throw('Invalid argument: "char" should be a single character')
  end

  if type(occurence) ~= 'number' then
    throwTypeError('occurence', 'number|nil', type(occurence))
  end

  local matchesFound = 0
  occurence = occurence or 1 -- default to the first occurrence if none is specified.
  local charsToReturn = {}

  -- iterate through the target string, character by character.

  local max = #target
  for i = 1, max do
    local currentChar = string.sub(target, i, i)

    -- once the target occurrence is reached, start collecting characters.
    if matchesFound >= occurence then
      table.insert(charsToReturn, currentChar)
    end

    -- increment the match count whenever the specified character is found.
    if char == currentChar then
      matchesFound = matchesFound + 1
    end
  end

  -- If the occurrence isn't found, we return an empty string,
  -- as there's nothing after the specified delimiter.
  return table.concat(charsToReturn)
end
