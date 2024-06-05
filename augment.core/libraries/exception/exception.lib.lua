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
-- World of Warcraft addon framework, created by Erik Riklund (2024)
--

--- @cast CORE framework
local self = CORE.libs.exception

--#region [method: throw]

--- ???
--
self.throw = function(message, ...)
  error(... and string.format(message, ...) or message)
end

--#endregion
