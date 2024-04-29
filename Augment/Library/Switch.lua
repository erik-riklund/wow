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
--- Provides a switch-like control flow mechanism using a lookup table.
--
-- This function offers more flexibility than traditional switch statements by 
-- allowing arbitrary expressions as keys within the `cases` table, and it supports
-- a default case.
--
-- @param value any The value to match against the keys in the `cases` table.
-- @param cases table A table (dictionary) where keys represent potential matches, 
--                    and values can be either:
--                    * Functions to execute if the key matches the value.
--                    * Any other value to directly return if the key matches.
-- @return any The result of executing the matching function, the direct value, or 
--             the result from the "default" case if no other match is found.
-- @throws error If the 'cases' argument is not a table.
--

Switch = function(value, cases)
  if type(cases) ~= "table" then
    error("Expected type `table` for parameter 'cases'")
  end

  local match = cases[value] or cases["default"]
  return When(type(match) == "function", function() return match() end, match)
end
