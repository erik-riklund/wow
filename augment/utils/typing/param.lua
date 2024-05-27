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
_G.param =
{
  --
  --- ???
  --
  --- @return param
  --
  required = function(name, expected_type) end,

  --
  --- ???
  --
  --- @return param
  --
  optional = function(name, expected_type, default_value) end
}
