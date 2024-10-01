--[[~ Library: Type Extension ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/01

  Provides an extension to the standard Lua types, introducing additional types to allow
  for more fine-grained type safety. The new types are `array` (numerically indexed table),
  `hashmap` (associative table), `character` (single-letter string), and `undefined` (nil).

  Additionally, includes functions for classifying values using the full range of types,
  comparing values against a single or list of expected types, and validating function
  arguments using string-based rules with an intuitive syntax.

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
    -- of elements in the table and compare that to the number returned by the # operator.
    -- If the numbers match, the table is classified as an array.

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

  -- Iterate over the specified expected type(s) to compare the value against each.

  if type(types) ~= 'table' then types = { types } end

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
---@param arguments array<{ rule: string, value: unknown }>
---
backbone.validateExtendedTypes = function(arguments)
  if not backbone.isProductionMode() then
    for index, argument in ipairs(arguments) do
      -- [explain this section]

      ---@type string, string?
      local identifier, types = string.split(':', argument.rule)

      if types == nil then
        local message = 'Missing type declaration for argument "%s".'
        error(string.format(message, identifier), 3)
      end

      -- [explain this section]

      local optional = (string.sub(types, -1) == '?')
      if optional == true then types = string.sub(types, 1, #types - 1) end

      -- [explain this section]

      ---@type ExtendedType[]
      local expectedTypes = { string.split('/', types) }
      local typesMatch, extendedType =
        backbone.compareExtendedTypes(argument.value, expectedTypes)

      if not typesMatch and not (extendedType == 'undefined' and optional) then
        local expected = table.concat(expectedTypes, ' or ')
        local message = 'Invalid argument type for "%s": expected %s, got %s.'

        error(message:format(identifier, expected, extendedType), 3)
      end
    end
  end
end
