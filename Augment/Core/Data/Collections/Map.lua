local ADDON, CORE = ...
local Packages, Object = CORE.Packages, CORE.Object

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
local Collection = Packages:Use("Core.Data", {"Collection"})
local Map = Packages:Add("Core.Data.Collections", Collection:Extend("Map"))
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--[ Map:Init ]
--
-- ???
--
function Map:Init(expected_types, initial_state)
  local key_type, value_type = unpack(expected_types or {"any", "any"})
  --
  self.parent:Init(("map(%s, %s)"):format(key_type, value_type))
  self._content = initial_state or {}
end

--
--[ Map:Size ]
--
-- ???
--
function Map:Size()
  --
  local count = 0
  for _,_ in self:GetIterator() do
    count = count + 1
  end
  --
  return count
end

--
--[ Map:GetIterator ]
--
-- ???
--
function Map:GetIterator()
  return pairs(self._content)
end
