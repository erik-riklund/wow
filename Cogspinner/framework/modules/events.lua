--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local _, context = ...
--- @cast context core.context

local setmetatable = setmetatable

--#region (framework context imports)

--- @type framework.frame
local frame = context:import('frame')

--- @type plugin.base_context
local framework = context:import('plugin')

--- @type module.network
local network = context:import('module/network')

--- @type module.plugins
local plugin_manager = context:import('module/plugins')

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

  register = function(self, listener)
    if string.sub(listener.event, 1, 12) ~= 'ADDON_LOADED' then
      frame:register_event(listener.event)
    end
  end,

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

  initialize = function(self, plugin)
    local event = 'ADDON_LOADED:' .. plugin_manager.normalize_id(plugin)

    if self.listeners:has(event) then
      self:invoke(event)
      self.listeners:drop(event)
    end
  end
}

--
-- ?
--

frame:register_event_handler(
  function(event, ...)
    if event == 'ADDON_LOADED' then
      event_handler:initialize(...)
    else
      event_handler:invoke(event, ...)
    end
  end
)

--#endregion

--#region [metatable: event API]

--
-- ?
--

local event_api =
{
  __index =
  {
    --
    -- ?
    --

    listen = function(self, listener)
      if listener.event == 'ADDON_LOADED' then
        throw('?')
      end


    end,

    --
    -- ?
    --

    silence = function(self, listener)
      if listener.event == 'ADDON_LOADED' then
        throw('?')
      end

      
    end,

    --
    -- ?
    --

    initialize = function(self, callback)
      self:listen({ event = 'ADDON_LOADED:' .. self.parent.id, callback = callback })
    end

  } --[[@as events.API]]

}

--
-- ?
--

network:monitor(
  framework, 'PLUGIN_ADDED', {
    callback = function(payload)
      --- @cast payload plugin.added.payload

      local plugin = payload.plugin
      plugin.event = setmetatable({ parent = plugin }, event_api)
    end
  }
)

--#endregion

--
-- ?
--

context:export('module/events', event_handler)
