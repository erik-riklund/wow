--
--      #
--     # #   #    #  ####  #    # ###### #    # #####
--    #   #  #    # #    # ##  ## #      ##   #   #
--   #     # #    # #      # ## # #####  # #  #   #
--   ####### #    # #  ### #    # #      #  # #   #
--   #     # #    # #    # #    # #      #   ##   #
--   #     #  ####   ####  #    # ###### #    #   #
--
-- World of Warcraft addon ecosystem, created by Erik Riklund (2024)
--

--
--- This function creates a standardized parameter definition for use in other validation functions.
--- It helps ensure consistent parameter checking and error reporting within your addon.
--
--- @param name string
--- @param expected_type string
--- @param flags? table
---
--- @params
--- * name: string - The name of the parameter (used in error messages if validation fails).
--- * expected_type: string - The string representation of the expected data type.
--- * flags?: table - Optional flags used to apply rules or enforce additional constraints.
---
--- validation flags
--- * optional: boolean - Mark the parameter as optional. If a default value is provided, this can be omitted.
--- * default: any - Set the default value of the parameter, effectively making it optional.
--- * empty: boolean - Choose whether to extend validation to include checking for an empty argument.
--
_G.param = function(name, expected_type, flags)
  --
  local optional = flags and flags.optional
  local default_value = flags and flags.default

  assert(
    type(name) == "string",
    "Expected type `string` for 'name'"
  )

  assert(
    type(expected_type) == "string",
    "Expected type `string` for 'expected_type'"
  )

  return { name = name, type = expected_type, optional = optional, default = default_value }
end
