--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local _, context = ...
--- @cast context core.context

--#region (framework context imports)

--- @type plugin.API
local plugin = context:import('plugin')

--- @type module.events
local event_handler = context:import('module/events')

--#endregion

--
-- ?
--

event_handler:register(
  {
    owner = plugin,

    event = 'PLAYER_ENTERING_WORLD',
    callback = function(...) collectgarbage() end
  }
)

--
-- ?
--

event_handler:register(
  {
    owner = plugin,

    event = 'ADDON_LOADED',
    callback = function(...)
      print('Hello world')
      collectgarbage()
    end
  }
)
