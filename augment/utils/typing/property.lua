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

_G.property = {}

--
--- Defines a blueprint for a required property within an object,
--- specifying the expected data type for its value.
--
--- @param expected_type string|schema
--- @return property
--
function property.required(expected_type)
  return { type = expected_type }
end

--
--- Defines a blueprint for an optional property within an object,
--- specifying its expected data type and a default value to be used
--- if the property is not provided.
--
--- @param expected_type string|schema
--- @param default_value? any
--
--- @return property
--
function property.optional(expected_type, default_value)
  return { type = expected_type, optional = true, default = default_value }
end
