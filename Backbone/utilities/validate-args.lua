--[[

  Project: Backbone (framework)
  Utility: Argument Validation
  Version: 1.0.0

  Author(s): Erik Riklund
  Created: 2024/09/22 | Updated: 2024/09/22

  Description:
  Provides a utility function for validating arguments based on expected types. If an 
  argument does not match the expected types, an error is raised with a detailed message.

  Notes:

  - This function supports optional arguments and compares the actual type with the expected types.

]]

---
--- Validates a list of arguments by comparing their actual types against the expected
--- types. If a type mismatch occurs and the argument is not optional, an error is raised.
---
--- @param arguments argumentValidation[] "A list of arguments to validate, each containing a value, label, and expected types."
---
_G.validateArguments = function(arguments)
  --
  -- Iterates through each argument and validates its type.

  for index, argument in ipairs(arguments) do
    --
    -- Compares the argument's type with the expected types.

    local typesMatch, extendedType = compareExtendedTypes(argument.value, argument.types)
    if not typesMatch and not (extendedType == 'undefined' and argument.optional == true) then
      --
      -- Constructs an error message for invalid argument types.

      local message = 'Invalid argument type (%s): expected %s, received %s.'
      local expected = (type(argument.types) == 'string' and argument.types)
        or table.concat(argument.types --[[@as array<string>]], ' or ')

      -- Throws the error with the constructed message.

      throwError(message, argument.label, expected, extendedType)
    end
  end
end
