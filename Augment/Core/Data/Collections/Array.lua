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
local Array = Packages:Add("Core.Data.Collections", Collection:Extend("Array"))
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--[ Array:Init ]
--
-- ???
--
function Array:Init(content_type, initial_state)
  self.parent:Init(("array(%s)"):format(content_type or "any"))
  self._content = initial_state or {}
end

--
--[ Array:Length ]
--
-- ???
--
function Array:Count()
  return #self._content
end

--
--[ Array:GetIterator ]
--
-- ???
--
function Array:GetIterator()
  return ipairs(self._content)
end
