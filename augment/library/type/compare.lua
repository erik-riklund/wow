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

_G.compare = function(value, expected_type, default_value)
  local actual_type = typeof(value or default_value)
  local passed = actual_type == expected_type or expected_type == "any" and actual_type ~= "undefined"
      or (expected_type == "array" or expected_type == "hashmap") and actual_type == "table"

  return {
    value = value or default_value,
    error = not passed and ("Expected type `%s` but recieved `%s`"):format(expected_type, actual_type) or nil
  }
end
