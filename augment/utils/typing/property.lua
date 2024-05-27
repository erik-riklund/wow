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
--- ???
--
_G.property =
{
  --
  --- ???
  --
  --- @param expected_type string|schema
  --- @return property
  --
  required = function(expected_type)
    return { expected_type = expected_type }
  end,

  --
  --- ???
  --
  --- @param expected_type string|schema
  --- @param default_value? any
  --
  --- @return property
  --
  optional = function(expected_type, default_value)
    return { expected_type = expected_type, optional = true, default = default_value }
  end
}
