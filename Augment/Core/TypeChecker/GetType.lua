local ADDON, CORE = ...

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
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--
local TypeChecker, Map = CORE.Utils.TypeChecker, CORE.Data.Structures.Map
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--[ TypeChecker:GetType ]
--
-- Inspect the provided `value` to determine its type. New types introduced are `undefined` (nil),
-- `array` (tables with numeric indexes), and `map` (tables with associative keys).
--
-- Other types used are the built-in Lua types:
-- string, number, boolean, function, userdata, thread
--
function TypeChecker:GetType(value)
  --
  local actual_type = type(value)
  --
  return Switch(
    actual_type,
    {
      --
      ["table"] = function()
        return self:GetTableType(value)
      end,
      --
      ["nil"] = "undefined",
      ["default"] = actual_type
    }
  )
end

--
--[ TypeChecker:GetTableType ]
--
-- Determines if a given table is considered an array (only numeric indexes) or an associative map.
--
function TypeChecker:GetTableType(table)
  --
  local tree = Map:New({"any", "any"}, table)
  --
  local is_empty = next(table) == nil
  local total_keys = tree:GetKeyCount()
  local numeric_keys = #table
  --
  return ((is_empty or total_keys == numeric_keys) and "array") or "map"
end
