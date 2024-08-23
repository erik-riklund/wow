--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local setmetatable = setmetatable
local _, context = ... --- @cast context core.context

--#region (context imports)

--- @type module.tasks
local tasks = context:import('module/tasks')

--- @type module.network
local network = context:import('module/network')

--- @type resource.shared.frame
local frame = context:import('resource/shared/frame')

--- @type utility.collection.map
local map = context:import('utility/collection/map')

--- @type utility.collection.list
local list = context:import('utility/collection/list')

--- @type plugin.API
local framework = context:import('resource/internal/plugin')

--#endregion

--
-- ?
--

--- @type module.events
local event_manager =
{
  --
  -- ?
  --

  listeners = map(),

  --
  -- ?
  --


}

--
-- ?
--

--- @type events.API
local events_api =
{
  --
  -- ?
  --

  parent = nil,

  --
  -- ?
  --

  listen = function(self, options) end,

  --
  -- ?
  --

  silence = function(self, event, callback_id) end
}

--
-- ?
--

network:monitor(
  framework, 'PLUGIN_ADDED', {
    callback = function(payload)
      --- @cast payload table
      local plugin = payload.plugin --[[@as plugin.context]]

      plugin.events = setmetatable(
        { parent = plugin }, { __index = events_api }
      )
    end
  }
)

--
-- ?
--

frame:register_event_handler(
  function(event, ...)

  end
)
