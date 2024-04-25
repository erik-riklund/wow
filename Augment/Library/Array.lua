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

--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--
-- Function: Array:Merge
-- Purpose: Combines the elements of two arrays into a single, unified array.
--
-- Parameters:
--   first (array): The first array to be merged.
--   second (array): The second array to be merged.
--
-- Returns:
--   (array): A new array containing all elements from the original first array
--            followed by the elements of the second array.
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

function Array:Merge(first, second)
  local first = Type:Validate("first", first, Type:Array())
  local second = Type:Validate("second", second, Type:Array())

  for _, value in second do
    table.insert(first, value)
  end

  return first
end

--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--
-- Function: Array:Contains
-- Purpose: Determines if a specified value exists within a given array.
--
-- Parameters:
--   target (array): The array to be searched.
--   value : The value to locate within the array.
--
-- Returns:
--   `true`: If the value is found in the array.
--   `false`: If the value is not found in the array.
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

function Array:Contains(target, value)
  local target = Type:Validate("target", target, Type:Array())

  if Type:GetType(value) ~= "undefined" then
    for _, v in ipairs(target) do
      if v == value then
        return true
      end
    end
  end

  return false
end
