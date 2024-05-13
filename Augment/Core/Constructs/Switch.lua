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
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--[ switch ]
--
-- Provides a switch-like control flow mechanism using a lookup table.
--
switch = function(value, cases)
  if type(cases) ~= "table" then
    error("Expected type `table` for parameter 'cases'")
  end

  local match = cases[value] or cases["default"]
  return (type(match) == "function" and match()) or match
end
