--[[~ Library: Type Extension ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/30

  ?

]]

---
--- Examines the given value and returns an extended type classification.
---
---@param target unknown
---@return ExtendedType
---
backbone.getExtendedType = function(target)
  local targetType = type(target)

  -- For tables, we need to determine if it's numerically or associatively indexed to
  -- classify it properly. Empty tables are classified as the standard 'table' type.

  if targetType == 'table' then
    if next(target) == nil then
      return 'table' -- empty table.
    end

    -- To distinguish between arrays and hashmaps, we need to count the actual number
    -- of elements that the table have and compare that to the number returned by the
    -- # operator. If the numbers match, the table is classified as an array.

    local elementCount = #target
    local actualElementCount = 0

    for _ in pairs(target) do
      actualElementCount = actualElementCount + 1
    end

    return (elementCount == actualElementCount and 'array') or 'hashmap'
  end

  -- Single-letter strings are classified as the 'character' type.

  if targetType == 'string' and string.len(target) == 1 then
    return 'character' --
  end

  -- For other value types, return the standard Lua type,
  -- with the exception of 'nil' being classified as 'undefined'.

  return (targetType == 'nil' and 'undefined') or targetType --[[@as ExtendedType]]
end

---
--- Compares a value against one or more expected types.
---
---@param value unknown
---@param types ExtendedType | ExtendedType[]
---@return boolean, ExtendedType
---
backbone.compareExtendedTypes = function(value, types)
  local extendedType = backbone.getExtendedType(value)

  -- Performance is more important than type safety in production environments.

  if backbone.isProductionMode() then
    return true, extendedType --
  end

  -- [explain this section]

  if type(types) ~= 'table' then
    types = { types } -- convert a single type into an array.
  end

  for index, expectedType in ipairs(types) do
    if extendedType == expectedType then
      return true, extendedType -- matching types.
    end

    -- [explain this section]

    if extendedType == 'character' and expectedType == 'string' then
      return true, 'string' --
    end

    -- [explain this section]

    if extendedType == 'table' then
      if expectedType == 'array' or expectedType == 'hashmap' then
        return true, expectedType
      end
    end
  end

  -- The provided value did not match any of the expected types,
  -- hence we return `false` alongside the type classification.

  return false, extendedType
end

---
--- ?
---
backbone.validateExtendedTypes = function() end
