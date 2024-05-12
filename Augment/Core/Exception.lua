local error = error
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
--[ Exception ]
--
-- ???
--
Exception = {
  --
  --[ InvalidType ]
  --
  -- ???
  --
  InvalidType = function(self, expected_type, actual_type)
    error(("Expected type `%s`, recieved `%s`"):format(expected_type, actual_type))
  end
}

--
-- ???
--
Export("Core.Exception", Exception)
