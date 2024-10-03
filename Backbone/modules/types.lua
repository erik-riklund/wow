--[[~ Module: Type Extension ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/01

  Provides an extension to the standard Lua types, introducing additional types to allow
  for more fine-grained type safety. The new types are `array` (numerically indexed table),
  `hashmap` (associative table), `character` (single-letter string), and `undefined` (nil).

  Additionally, includes functions for classifying values using the full range of types,
  comparing values against one or multple expected types, and validating function arguments
  using string-based rules with an intuitive syntax.

]]

---
--- Examines the given value and returns its extended type classification.
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
--- Compares a given value against one or more expected types.
---
--- Returns a boolean that specify if the type of `value` match any of the specified `types`,
--- alongside the extended type classification of the provided value.
---
---@param value unknown
---@param types ExtendedType | ExtendedType[]
---@return boolean, ExtendedType
---
backbone.compareExtendedTypes = function(value, types)
  local extendedType = backbone.getExtendedType(value)

  -- Performance is more important than type safety in production environments.

  if backbone.getEnvironment() == 'production' then
    return true, extendedType --
  end

  -- Iterate over the specified expected type(s) to compare the value against each.

  if type(types) ~= 'table' then types = { types } end

  for index, expectedType in ipairs(types) do
    if extendedType == expectedType then
      return true, extendedType -- matching types.
    end

    -- Strings classified as `character` should still count as a string
    -- if that is the expected type, but not the other way around.

    if extendedType == 'character' and expectedType == 'string' then
      return true, 'string' --
    end

    -- Since empty tables are indistinguishable between arrays and hashmaps,
    -- the expected type (`array` or `hashmap`) is explicitly returned.

    if extendedType == 'table' then
      if expectedType == 'array' or expectedType == 'hashmap' then
        return true, expectedType
      end
    end
  end

  -- The provided value did not match any of the expected types; therefore,
  -- the returned values are `false` and the type classification.

  return false, extendedType
end

---
--- Performs rule-based type validation of the provided arguments.
---
---@param arguments array<{ rule: string, value: unknown }>
---@param throwErrors? boolean
---
---@return boolean?, { identifier: string, actualType: ExtendedType, expectedTypes: ExtendedType[] }?
---
backbone.validateExtendedTypes = function(arguments, throwErrors)
  if type(throwErrors) ~= 'boolean' then throwErrors = true end

  if backbone.getEnvironment() == 'development' then
    -- Iterate over the provided arguments, ensuring that each contain a valid type declaration.

    for index, argument in ipairs(arguments) do
      ---@type string, string?
      local identifier, types = string.split(':', argument.rule)

      if types == nil then
        local message = 'Missing type declaration for argument "%s".'
        error(string.format(message, identifier), 3)
      end

      -- Determine if the argument is marked as optional. If it is, remove the trailing question mark.

      local optional = (string.sub(types, -1) == '?')
      if optional == true then types = string.sub(types, 1, #types - 1) end

      -- To perform the actual type validation, the type definition is split into an array.
      -- If the type comparison fails and the argument is not marked as optional,
      -- an error is thrown by default, or the result is returned as a hashmap.

      ---@type ExtendedType[]
      local expectedTypes = { string.split('/', types) }
      local typesMatch, extendedType =
        backbone.compareExtendedTypes(argument.value, expectedTypes)

      if not typesMatch and not (extendedType == 'undefined' and optional) then
        if throwErrors == true then
          local expected = table.concat(expectedTypes, ' or ')
          local message = 'Invalid argument type for "%s": expected %s, got %s.'

          error(message:format(identifier, expected, extendedType), 3)
        end

        -- If the default behavior is explicitly disabled, the returned values are
        -- `false` and a hashmap containing information about the failed validation.

        return false,
          {
            identifier = identifier,
            actualType = extendedType,
            expectedTypes = expectedTypes,
          }
      end
    end
  end
end
