--[[

  Project: Stem (framework)
  Utility: Argument Validation
  Version: 1.0.0

  Author(s): Erik Riklund
  Created: 2024/09/21 | Updated: 2024/09/21

  Description:
  Provides a utility to validate arguments by comparing their actual types with the expected 
  types. It supports optional arguments and throws descriptive errors if a type mismatch occurs.

  Notes:

  - This utility leverages the extended type system and supports validation for optional arguments.
  
]]

---
--- Validates a list of arguments by checking if their types match the expected types.
--- If the argument is marked as optional and has an 'undefined' type, no error is thrown.
---
--- @param arguments argumentValidation[] "A list of arguments to validate, each containing a value, label, and expected types."
---
_G.validateArguments = function(arguments)
  --
  -- Iterates over each argument, comparing the argument's type with the expected types.

  for index, argument in ipairs(arguments) do
    --
    -- Compares the argument's actual type with the expected types.

    local typesMatch, extendedType = compareExtendedTypes(argument.value, argument.types)

    -- Throws an error if the types don't match and the argument is not optional.

    if not typesMatch and not (extendedType == 'undefined' and argument.optional == true) then
      exception.type(argument.label, argument.types, extendedType)
    end
  end
end
