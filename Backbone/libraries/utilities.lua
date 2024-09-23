--[[~ Project: Backbone (framework) ~

  Library: Extended Type System & Error Handling
  Version: 1.0.0 | Updated: 2024/09/23

  This library extends Lua's basic type system to introduce more detailed types such 
  as `array`, `empty-table`, and `undefined`. These additions help provide clearer 
  validation, especially when working with complex data structures. The library also 
  includes utilities for error handling and argument validation to ensure that errors 
  are surfaced in a controlled and informative manner.

]]

---
--- Throws a formatted error. This function simplifies error handling by allowing
--- formatted messages, ensuring errors are informative. Using this centralizes
--- error handling logic and ensures consistency across the system.
---
--- @param description string   "The error message, which can include format specifiers."
--- @param ... string | number  "Optional arguments to format into the error message."
---
_G.throwError = function(description, ...)
  error((... and description:format(...)) or description, 3)
end

---
--- Determines the extended type of the target. This function provides more granular
--- types than Lua's built-in `type` function, offering types like `array`, `empty-table`,
--- and `undefined`. This helps developers more accurately validate and reason about
--- complex data structures.
---
--- @param target unknown "The value to determine the extended type of."
--- @return extendedType  "The extended type of the value."
---
_G.getExtendedType = function(target)
  local valueType = type(target)

  if valueType == 'table' then
    --
    -- An empty table is treated as a distinct type (`empty-table`), providing
    -- better semantic meaning when validating structures. This prevents confusion
    -- when distinguishing between an empty array and a non-empty table.

    if next(target) == nil then return 'empty-table' end

    --
    -- Check if the table behaves like an array (i.e., has sequential numeric keys).
    -- This helps differentiate between regular tables and arrays, improving validation.

    local elementCount = #target
    local actualElementCount = 0

    for _ in pairs(target) do
      actualElementCount = actualElementCount + 1
    end

    --
    -- If the number of elements in the table matches its length, it's considered
    -- an array. Otherwise, it remains a generic table. This distinction improves
    -- flexibility when dealing with data structures.

    return (elementCount == actualElementCount and 'array') or 'table'
  end

  --
  -- Return `undefined` instead of `nil` to align with common programming conventions,
  -- making type checking more consistent with broader development practices.

  return (valueType == 'nil' and 'undefined') or valueType --[[@as extendedType]]
end

---
--- Compares the extended type of a value against one or more expected types.
--- This function simplifies type validation by supporting multiple types and
--- offering special handling for `empty-table`, which can be treated as an array
--- or table based on context.
---
--- @param value unknown "The value to compare."
--- @param types extendedType | extendedType[] "The expected types."
--- @return boolean, extendedType "Whether the types match, and the actual extended type."
---
_G.compareExtendedTypes = function(value, types)
  local extendedType = getExtendedType(value)

  --
  -- Ensure `types` is always an array, which simplifies the logic and makes the
  -- function easier to use when multiple types are expected.

  if type(types) ~= 'table' then
    types = { types } -- convert a single type into an array.
  end

  --
  -- Iterate through the expected types, returning true if there's a match.
  -- This supports flexible type checking, allowing developers to specify
  -- multiple potential types for comparison.

  for index, expectedType in ipairs(types) do
    if expectedType == extendedType then
      return true, extendedType -- match found.
    end

    --
    -- Special handling for `empty-table`, which can be treated as either an
    -- array or table. This flexibility ensures that empty collections are
    -- handled gracefully.

    if extendedType == 'empty-table' then
      if expectedType == 'array' or expectedType == 'table' then
        return true, expectedType -- match found for `empty-table` as array or table.
      end
    end
  end

  return false, extendedType
end

---
--- Validates a list of arguments by comparing their actual types against expected types.
--- This function helps developers enforce consistency in function parameters and input
--- validation. It supports optional arguments and provides detailed error messages,
--- ensuring that errors are easy to understand and debug.
---
--- @param arguments argumentValidation[] "The list of arguments to validate, each with a label and a value."
---
_G.validateArguments = function(arguments)
  if _G.production ~= true then
    --
    -- Iterate through each argument and perform type validation. This ensures that
    -- functions receive the correct types of arguments, reducing the risk of runtime errors.

    for index, argument in ipairs(arguments) do
      local options, value = unpack(argument)
      local identifier, types = string.split(':', options)

      --
      -- Ensure that the validation rule is correctly formatted. This prevents
      -- malformed validation rules from causing unexpected behavior.

      if types == nil then throwError('Invalid validation rule "%s"', options) end

      --
      -- Handle optional arguments. The `?` suffix indicates that an argument is
      -- optional, allowing it to be omitted without throwing an error.

      local optional = xstring.hasSuffix(types, '?')
      if optional == true then types = types:sub(1, #types - 1) end

      ---@type extendedType[]
      local expectedTypes = { string.split('/', types) }
      local typesMatch, extendedType = compareExtendedTypes(value, expectedTypes)

      --
      -- Throw an error if the argument type does not match the expected types.
      -- This ensures that developers receive clear, actionable error messages
      -- when their input doesn't conform to expectations.

      if not typesMatch and not (extendedType == 'undefined' and optional == true) then
        local message = 'Invalid argument type (%s): expected %s, received %s.'
        local expected = table.concat(expectedTypes, ' or ')

        throwError(message, identifier, expected, extendedType)
      end
    end
  end
end
