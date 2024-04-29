Array = {}

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
--- Modifies an array by appending elements from another array.
--
-- This function changes the first array by adding all elements from the second array 
-- to its end. It assumes that both arrays contain elements of compatible types.
--
-- @param first table The array to be modified.
-- @param second table The array whose elements will be added to 'first'.
-- @return table The modified 'first' array.
--

function Array:Merge(first, second)
  if type(first) ~= "table" or type(second) ~= "table" then
    error("Expected type `table` for both parameters")
  end

  for _, value in second do
    table.insert(first, value)
  end

  return first
end

--
--- Checks if a value exists in an array (table with numerical indices).
--
-- This function is intended for arrays where values are stored in consecutive 
-- numerical indices. 
--
-- @param target table The array to search.
-- @param value any The value to search for.
-- @return boolean True if the value is found in the array, False otherwise.
-- @throws error If the target is not a table.
--

function Array:Contains(target, value)
  if type(target) ~= "table" then
    error("Expected type `table` for target")
  end

  if type(value) ~= "nil" then
    for _, v in ipairs(target) do
      if v == value then
        return true
      end
    end
  end

  return false
end
