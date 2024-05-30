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

_G.argument = {}

--
--- Establishes a required function argument or schema property with a strict
--- data type constraint.
--
--- @param expected_type string|schema
--- @return argument
--
function argument.required(expected_type)
  return { type = expected_type }
end

--
--- Creates a definition for a function argument or schema property that
--- is not required (optional). It also specifies the expected data type and
--- an optional default value to use if the argument is not provided.
--
--- @param expected_type string|schema
--- @param default_value? any
--
--- @return argument
--
function argument.optional(expected_type, default_value)
  return { type = expected_type, optional = true, default = default_value }
end
