--[[

  Project: Stem (framework)
  Utility: Argument Validation
  Version: 1.0.0

  Author(s): Erik Riklund
  Created: 2024/09/20 | Updated: 2024/09/20

  Description:
  Provides a utility function to validate the types of a list of arguments. It compares 
  each argument's actual type to an expected set of types and throws an error if the types 
  do not match.

  Notes:

  - This function leverages the extended type system to support additional type checks.

]]

---
--- Validates a list of arguments, comparing each argument's actual type to the expected 
--- types. If an argument's type does not match the expected type(s), an error is thrown 
--- using the `exception.type` method.
---
--- @param arguments argumentValidation[] "A list of arguments to validate, each containing a value, label, and expected types."
---
_G.validateArguments = function(arguments)
  --
  -- Iterates through the list of arguments and checks their types using the extended type 
  -- comparison function. Throws an error if the actual type does not match the expected type(s).

  for index, argument in ipairs(arguments) do
    local result, actualType = compareExtendedTypes(argument.value, argument.types)

    if result == false then
      exception.type(argument.label, argument.types, actualType)
    end
  end
end
