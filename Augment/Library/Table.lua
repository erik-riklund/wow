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
-- Function: Table.HasKey
-- Purpose:  Determines whether a specified key exists within a given table.
--
-- Parameters:
--   target (table): The table to be searched.
--   key (any): The key to locate within the table.
--
-- Returns:
--   1) `true`: If the key exists in the table.
--   2) `false`: If the key does not exist in the table.
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

function Table:HasKey(target, key)
  --
  if type(target) ~= "table" then
    error("Expected type `table` for target")
  end
  if type(key) == "nil" then
    error("Missing parameter `key`")
  end

  return target[key] ~= nil
end
