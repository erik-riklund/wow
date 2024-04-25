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
--   key (string): The key to locate within the table.
--
-- Returns:
--   1) `true`: If the key exists in the table.
--   2) `false`: If the key does not exist in the table.
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

function Table:HasKey(target, key)
  local target = Type:Validate("target", target, Type:OneOf(Type:Table(), Type:Array()))
  local key = Type:Validate("key", key, Type:String())

  return target[key] ~= nil
end
