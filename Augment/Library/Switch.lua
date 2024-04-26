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
--  Function: Switch
--  Purpose:  Provides a switch-like control flow mechanism in Lua, which doesn't have a native switch statement.
--
--  Parameters:
--    value: The value to be compared against different cases.
--    cases (table): A table (like a dictionary) where:
--        Keys: Represent the potential values to match against.
--        Values: Can be either:
--            Functions to be executed if the corresponding key matches the value.
--            Direct values to be returned if the key matches.
--  
--  Returns:  
--   1) The result of executing the matched function (if a function was provided).
--   2) The direct value associated with the matched case (if no function was provided).
--   3) The value associated with the 'default' case if no other case matches.
--   4) `nil` if no case matches and no 'default' case is provided.
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

Switch = function(value, cases)
  if type(cases) ~= "table" then
    error("Expected type `table` for parameter 'cases'")
  end

  local match = cases[value] or cases["default"]
  return When(type(match) == "function", function() return match() end, match)
end
