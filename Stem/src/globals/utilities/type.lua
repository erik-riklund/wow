--[[

  Project: Stem (framework)
  Module: Extended Type System
  Version: 1.0.0

  Author(s): Erik Riklund
  Created: 2024/09/20 | Updated: 2024/09/20

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
  -- ?

  local valueType = type(target)

  -- ?

  if valueType == 'table' then
    -- ?

    if next(target) == nil then
      return 'empty-table'
    end

    -- ?

    local elementCount = #target
    local actualElementCount = 0

    for _ in pairs(target) do
      actualElementCount = actualElementCount + 1
    end

    -- ?

    return (elementCount == actualElementCount and 'array') or 'table'
  end

  -- ?

  return (valueType == 'nil' and 'undefined') or valueType --[[@as extendedType]]
end

---
--- ?
---
--- @param value unknown "..."
--- @param types extendedType|array<extendedType> "..."
---
--- @return boolean, extendedType "..."
---
_G.compareExtendedTypes = function(value, types)
  --
  -- ?

  local extendedType = getExtendedType(value)

  -- ?

  if type(types) ~= 'table' then
    types = { types }
  end

  -- ?

  for index, expectedType in ipairs(types) do
    -- ?

    if expectedType == extendedType then
      return true, extendedType -- ?
    end
  end

  -- ?

  return false, extendedType
end
