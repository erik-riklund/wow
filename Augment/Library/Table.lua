Table = {}

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
-- Determines whether a specified key exists within a given table.
--
-- Parameters:
--   target (table): The table to be searched.
--   key (any): The key to locate within the table.
--
-- Returns:
--   1) true: If the key exists in the table.
--   2) false: If the key does not exist in the table.
--

function Table:HasKey(target, key)
  --
  if type(target) ~= "table" then
    error("Expected type `table` for parameter 'target'")
  end
  if type(key) == "nil" then
    error("Missing parameter 'key'")
  end

  return target[key] ~= nil
end

--
-- Extracts all keys from a given table and returns them as an array.
--
-- Parameters:
--   target (table): The table whose keys will be collected.
--
-- Returns:
--   (array) An array containing all the keys present in the target table.
--

function Table:GetKeys(target)
  if type(target) ~= "table" then
    error("Expected type `table` for parameter 'target'")
  end

  local keys = {}
  for key in pairs(target) do
    table.insert(keys, key)
  end

  return keys
end

--
-- Counts the number of keys within a given table.
--
-- Parameters:
--   target (table): The table whose keys will be counted.
--
-- Returns:
--   (number) The total count of keys found within the target table.
--

function Table:KeyCount(target)
  return #self:GetKeys(target)
end
