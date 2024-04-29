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
--- Checks if a key exists in a table (dictionary).
--
-- @param target table The table to search.
-- @param key any The key to search for.
-- @return boolean True if the key exists in the target table, False otherwise.
-- @throws error If the 'target' is not a table or the 'key' is missing.
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
--- Gets all the keys from a table (dictionary).
--
-- @param target table The table to get the keys from.
-- @return table A new table containing all the keys from the target table.  
-- @throws error If the target is not a table.
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
--- Counts the number of keys in a table (dictionary).
--
-- @param target table The table to count the keys of.
-- @return number The number of keys in the target table.
-- @throws error If the 'target' is not a table.
--

function Table:KeyCount(target)
  return #self:GetKeys(target)
end
