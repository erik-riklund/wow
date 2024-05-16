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
local inspect = import({"types.inspect"})
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--[ check ]
--
-- Asserts that a value matches the expected type, using the 'inspect' function
-- for type inspection. Throws an error if the types do not match.
--
local check = function(expected_type, value)
  local actual_type = inspect(value)
  assert(actual_type == expected_type,
    catch("Expected type `%s`, recieved `%s`", expected_type, actual_type)
  )

  return value
end

--
export("types.check", check)
