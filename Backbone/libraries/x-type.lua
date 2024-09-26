--[[~ Library: Type Extension (xtype) ~

  Version: 1.0.0 | Updated: 2024/09/25

  A library extending Lua's type system to offer more granular classifications, 
  such as differentiating between tables, arrays, and empty tables. It also 
  provides functionality for comparing types and validating arguments.

  Features:

  - Examine values to provide extended type classification (e.g., array, empty-table).
  - Compare a value against a list of expected types.
  - Validate function arguments to ensure they conform to specified types.

]]

_G.xtype = {}

---
--- Examines the provided value and returns an extended type classification.
--- For tables, it distinguishes between arrays, empty tables, and regular tables.
---
---@param value unknown "The value to be examined."
---@return xtype.type "The extended type classification of the value."
---
xtype.examine = function(value)
  local valueType = type(value)

  if valueType == 'table' then
    if next(value) == nil then return 'empty-table' end

    local elementCount = #value
    local actualElementCount = 0

    -- Count elements in the table to distinguish arrays from other tables.
    for _ in pairs(value) do
      actualElementCount = actualElementCount + 1
    end

    -- If the table is contiguous (array), return 'array', otherwise return 'table'.
    return (elementCount == actualElementCount and 'array') or 'table'
  end

  -- For non-table values, return their type, treating nil as 'undefined'.
  return (valueType == 'nil' and 'undefined') or valueType --[[@as xtype.type]]
end

---
--- Compares a value against one or more expected types. Returns true if the value
--- matches any of the provided types, with special handling for empty tables and arrays.
---
---@param value unknown "The value to be compared."
---@param types xtype.type | xtype.type[] "The expected type(s) to compare against."
---@return boolean, xtype.type "Whether the value matches the expected types and its actual type."
---
xtype.compare = function(value, types)
  local extendedType = xtype.examine(value)
  if _G.production == true then return true, extendedType end

  if type(types) ~= 'table' then types = { types } end
  for index, expectedType in ipairs(types) do
    if expectedType == extendedType then return true, extendedType end

    if extendedType == 'empty-table' then
      if expectedType == 'array' or expectedType == 'table' then
        return true, expectedType
      end
    end
  end

  return false, extendedType
end

---
--- Validates a set of arguments based on their expected types. Throws an error if
--- any argument does not match the expected type or is not optional.
---
---@param arguments xtype.validation[] "An array of argument specifications to validate."
---
xtype.validate = function(arguments)
  if _G.production ~= true then
    for index, argument in ipairs(arguments) do
      local options, value = unpack(argument)
      local identifier, types = string.split(':', options)
      if types == nil then error('Missing type declaration for argument.', 3) end

      local optional = xstring.hasSuffix(types, '?')
      if optional == true then types = types:sub(1, #types - 1) end

      ---@type xtype.type[]
      local expectedTypes = { string.split('/', types) }
      local typesMatch, extendedType = xtype.compare(value, expectedTypes)

      -- Throw an error if the argument type does not match the expected types.
      if not typesMatch and not (extendedType == 'undefined' and optional) then
        local message = 'Invalid argument type for "%s": expected %s, got %s.'
        local expected = table.concat(expectedTypes, ' or ')

        error(message:format(identifier, expected, extendedType), 3)
      end
    end
  end
end
