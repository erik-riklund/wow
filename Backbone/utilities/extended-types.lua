--[[

  Project: Backbone (framework)
  Module: Extended Type System
  Version: 1.0.0

  Author(s): Erik Riklund
  Created: 2024/09/20 | Updated: 2024/09/22

  Description:
  Provides a system to extend Lua's native type system by introducing new types such as 
  `array`, `empty-table`, and `undefined`. It allows for more granular type checking in 
  the framework.

  Notes:

  - This module introduces custom types for tables, including `array` and `empty-table`, 
    and replaces `nil` with `undefined`.

]]

---
--- Returns the extended type of the target. This extended system introduces `array` for
--- tables with sequential numeric keys, `empty-table` for empty tables, and `undefined`
--- for `nil` values.
---
--- @param target unknown "The value to determine the extended type of."
--- @return extendedType  "The extended type of the value."
---
_G.getExtendedType = function(target)
  --
  -- Retrieves the base type of the target.

  local valueType = type(target)

  -- Handles the special case of tables.

  if valueType == 'table' then
    --
    -- Returns "empty-table" if the table has no elements.

    if next(target) == nil then
      return 'empty-table'
    end

    -- Counts the elements in the table and compares the length to determine if it is an array.

    local elementCount = #target
    local actualElementCount = 0

    for _ in pairs(target) do
      actualElementCount = actualElementCount + 1
    end

    -- Returns "array" if the table has sequential numeric keys, otherwise returns "table".

    return (elementCount == actualElementCount and 'array') or 'table'
  end

  -- Returns "undefined" for `nil` values, otherwise returns the base type.

  return (valueType == 'nil' and 'undefined') or valueType --[[@as extendedType]]
end

---
--- Compares the extended type of a value with the expected types. Returns `true` if the
--- extended type matches one of the expected types, and `false` otherwise.
---
--- @param value unknown "The value whose type is to be compared."
--- @param types extendedType | array<extendedType> "The expected extended type or a list of types to compare against."
---
--- @return boolean, extendedType "Returns a boolean indicating if the types match, and the actual extended type."
---
_G.compareExtendedTypes = function(value, types)
  --
  -- Retrieves the extended type of the value.

  local extendedType = getExtendedType(value)

  -- Iterates through the expected types and checks if any match the extended type.

  if type(types) ~= 'table' then
    types = { types } -- convert a single type into an array.
  end

  for index, expectedType in ipairs(types) do
    --
    -- Returns true if the extended type matches the expected type.

    if expectedType == extendedType then
      return true, extendedType -- match found.
    end

    -- Special handling for empty tables, which can match both 'array' and 'table'.

    if extendedType == 'empty-table' then
      if expectedType == 'array' or expectedType == 'table' then
        return true, expectedType -- match found for 'empty-table' as array or table.
      end
    end
  end

  -- Returns `false` if no match is found, along with the actual extended type.

  return false, extendedType
end
