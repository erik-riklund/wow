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
--- This function acts as a judge, evaluating whether a given value aligns with the specified standard,
--- and providing feedback on the outcome of the comparison.
--
--- @param expected_type string
---
--- @params
--- * value: any            - The input value to be compared against the expected type.
--- * expected_type: string - A string representing the desired data type.
--- * default_value: any    - (optional) A value to use if the value is `nil`.
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
