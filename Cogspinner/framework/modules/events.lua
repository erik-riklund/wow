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


}

--
-- ?
--

--- @type events.API
local event_api =
{
  --#todo: implement when the handler is ready.
}

--
-- ?
--

frame:register_event_handler(
  function(event, ...)
    --#todo: link to the event handler when it's ready!
  end
)

--
-- ?
--

network:monitor(
  framework, 'PLUGIN_ADDED', {
    callback = function(payload)
      --- @cast payload plugin.added.payload
    end
  }
)
