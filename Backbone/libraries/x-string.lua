--[[~ Library: String Utilities ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/27

  ?

  Features:
  
  - ?

]]

_G.xstring = {}

---
--- ?
---
---@param target  string "?"
---@param prefix  string | string[] "?"
---
---@return boolean "?"
---
xstring.hasPrefix = function(target, prefix)
  if type(target) ~= 'string' then
    throw '?'
  end

  if type(prefix) == 'string' then
    prefix = { prefix } -- convert a single prefix to an array.
  end

  for index, value in ipairs(prefix) do
    if target:sub(1, string.len(value)) == value then
      return true -- ?
    end
  end

  return false
end

---
--- ?
---
---@param target string "?"
---@param suffix string | string[] "?"
---
---@return boolean "?"
---
xstring.hasSuffix = function(target, suffix)
  if type(target) ~= 'string' then
    throw '?'
  end

  if type(suffix) == 'string' then
    suffix = { suffix } -- convert a single suffix to an array.
  end

  local targetLength = string.len(target)
  for index, value in ipairs(suffix) do
    local suffixLength = string.len(value)

    if suffixLength <= targetLength then
      if string.sub(target, targetLength - suffixLength + 1) == value then
        return true -- ?
      end
    end
  end

  return false
end

---
--- ?
---
---@param target     string "?"
---@param character  string "?"
---@param occurence? number "?"
---
---@return string "?"
---
xstring.getSubstringAfter = function(target, character, occurence)
  if type(occurence) ~= 'number' then
    occurence = 1 -- ?
  end

  if type(character) ~= 'string' or string.len(character) > 1 then
    throw '?'
  end

  if type(target) ~= 'string' then
    throw '?'
  end

  ---@type string[]
  local result = {}
  local targetLength = string.len(target)
  local charactersFound = 0

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
