--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local _, context = ...
--- @cast context core.context

--#region (framework context imports)

--- @type framework.frame
local frame = context:import('frame')

--- @type plugin.base_context
local framework = context:import('plugin')

--- @type module.network
local network = context:import('module/network')

--- @type utility.collection.map
local map = context:import('utility/collection/map')

--#endregion

--#region [controller: event handler]

--
-- ?
--

--- @type module.events
local event_handler =
{
  --
  -- ?
  --

  listeners = map(),

  --
  -- ?
  --

  register = function(self, listener) end,

  --
  -- ?
  --

  unregister = function(self, listener) end,

  --
  -- ?
  --

  invoke = function(self, event, ...) end,

  --
  -- ?
  --

  initialize = function(self, plugin) end
}

--
-- ?
--

frame:register_event_handler(
  function(event, ...)
    --#todo: link to the event handler when it's ready!
  end
)

--#endregion

--#region [controller: event API]

--
-- ?
--

--- @type events.API
local event_api =
{
  --
  -- ?
  --

  activate = function(self, listener) end,

  --
  -- ?
  --

  deactivate = function(self, listener) end,

  --
  -- ?
  --

  initialize = function(self, callback) end
}

--
-- ?
--

network:monitor(
  framework, 'PLUGIN_ADDED', {
    callback = function(payload)
      --- @cast payload plugin.added.payload

      --#todo: attach the events API to the plugin.
    end
  }
)

--#endregion
