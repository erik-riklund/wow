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

_G.param = {}

--
--- Creates a definition for a function parameter that is mandatory
--- and must be of a specified data type.
--
--- @param name string
--- @param expected_type string|schema
--
--- @return parameter
--
function param.required(name, expected_type)
  return { name = name, type = expected_type }
end

--
--- Creates a definition for a function parameter that is not required (optional) and,
--- if provided, should be of a specified data type. It also allows for a default value
--- to be used if the parameter is omitted.
--
--- @param name string
--- @param expected_type string|schema
--- @param default_value? any
--
--- @return parameter
--
function param.optional(name, expected_type, default_value)
  return {
    name = name, type = expected_type, optional = true, default = default_value
  }
end
