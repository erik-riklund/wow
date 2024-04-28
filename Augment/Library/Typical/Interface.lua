local ADDON, CORE = ...

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

Type = {
  Enabled = true,
  --
  Errors = {
    INVALID_TYPE = "Expected value of type `$expected_type` for '$property', recieved `$actual_type`",
    INVALID_KEY_TYPE = "Expected key of type `$expected_type` for '$property', recieved `$actual_type`",
    UNKNOWN_PROPERTY = "The schema does not define a property named '$property'"
  }
}
