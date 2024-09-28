--[[~ Library: Type Extension ~

  Version: 1.0.0 | Updated: 2024/09/27

  This library provides extended type checking functionality, allowing the classification of 
  values into more specific types such as arrays, empty tables, characters, or regular tables.

  Features:

  - Classify values into extended types (arrays, empty tables, etc.).
  - Compare values against expected types with support for flexible type checking.
  - Validate function arguments against specified types with optional values.

]]

_G.xtype = {}

---
--- examine()
---
--- This function examines the given value and returns an extended type classification. For tables, 
--- it distinguishes between arrays, empty tables, and regular tables. It also classifies single 
--- characters as a separate type from strings, providing more granular type checking.
---
---@param value unknown "The value to be examined."
---@return xtype.type "The extended type classification of the value."
---
xtype.examine = function(value)
  local valueType = type(value)

  -- If the value is a table, check if it is empty. Then, count the number of elements and 
  -- compare it with the table's length to distinguish between arrays and regular tables.

  if valueType == 'table' then
    if next(value) == nil then
      return 'empty-table'
    end

    local elementCount = #value
    local actualElementCount = 0

    for _ in pairs(value) do
      actualElementCount = actualElementCount + 1
    end

    return (elementCount == actualElementCount and 'array') or 'table'
  end

  -- If the value is a string and its length is 1, it is classified as a 'character'.

  if valueType == 'string' and string.len(value) == 1 then
    return 'character' -- single character classified separately.
  end

  -- For non-table and non-string values, return the original type,
  -- with 'nil' being classified as 'undefined'.

  return (valueType == 'nil' and 'undefined') or valueType --[[@as xtype.type]]
end

---
--- compare()
---
--- This function compares a value against one or more expected types. It returns true if the value 
--- matches any of the provided types. Special handling is provided for 'character' being treated 
--- as a valid 'string' and for empty tables being treated as arrays or regular tables.
---
---@param value unknown "The value to be compared."
---@param types xtype.type | xtype.type[] "The expected type(s) to compare against."
---
---@return boolean, xtype.type "Whether the value matches the expected types and its actual type."
---
xtype.compare = function(value, types)
  local extendedType = xtype.examine(value)

  if _G.production == true then
    return true, extendedType -- skip validation in production mode.
  end

  if type(types) ~= 'table' then
    types = { types } -- convert a single type into an array.
  end

  -- Loop through the expected types, checking for a match with the value's extended type.
  -- Handle special cases for 'character' (treated as 'string') and empty tables.

  for index, expectedType in ipairs(types) do
    if expectedType == extendedType then
      return true, extendedType -- Types match.
    end

    if extendedType == 'character' and expectedType == 'string' then
      return true, 'string' -- a single character counts as a string, but not the other way around.
    end

    if extendedType == 'empty-table' then
      if expectedType == 'array' or expectedType == 'table' then
        return true, expectedType -- empty table treated as the expected type (array or table).
      end
    end
  end

  return false, extendedType
end

---
--- validate()
---
--- This function validates a set of arguments based on their expected types. It throws an error if 
--- any argument does not match the expected type or is not optional. The validation process handles 
--- optional arguments by recognizing the '?' suffix in the type declaration.
---
---@param arguments xtype.validation[] "An array of argument specifications to validate."
---
xtype.validate = function(arguments)
  if _G.production ~= true then
    --
    -- Loop through each argument and validate its type. The expected type is declared in the 
    -- format `identifier:type`, and the value is checked against this type.

    for index, argument in ipairs(arguments) do
      local options, value = unpack(argument)
      local identifier, types = string.split(':', options)

      if types == nil then
        error('Missing type declaration for argument.', 3)
      end

      -- Check if the type is optional (indicated by a '?' suffix). If so, remove the '?' before 
      -- validating the type. An optional type means that the value may be undefined.

      local optional = xstring.hasSuffix(types, '?')
      if optional == true then
        types = types:sub(1, #types - 1) -- remove the trailing question mark.
      end

      ---@type xtype.type[]
      local expectedTypes = { string.split('/', types) }
      local typesMatch, extendedType = xtype.compare(value, expectedTypes)

      -- If the types do not match and the value is not optional, throw an error indicating the 
      -- expected and actual types. The message is detailed to help with debugging.
      
      if not typesMatch and not (extendedType == 'undefined' and optional) then
        local expected = table.concat(expectedTypes, ' or ')

        local message = 'Invalid argument type for "%s": expected %s, got %s.'
        error(message:format(identifier, expected, extendedType), 3)
      end
    end
  end
end
