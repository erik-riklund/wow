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
--[ Switch ]
--
-- Provides a switch-like control flow mechanism using a lookup table.
-- * value [any]: The value used to search for a matching case.
-- * cases [table]: Lookup table specifying values or operations for each possible case.
--
Switch = function(value, cases)
  --
  if type(cases) ~= "table" then
    error("Expected type `table` for parameter 'cases'")
  end
  --
  local match = cases[value] or cases["default"]
  return (type(match) == "function" and match()) or match
end
