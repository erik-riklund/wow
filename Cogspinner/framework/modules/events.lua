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
local plugin = context:import('plugin')

--- @type module.network
local network = context:import('module/network')

--- @type module.plugins
local plugin_manager = context:import('module/plugins')

--- @type utility.collection.map
local map = context:import('utility/collection/map')

--- @type utility.collection.list
local list = context:import('utility/collection/list')

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

  listeners = map(
    {
      ADDON_LOADED = map()
    }
  ),

  --
  -- ?
  --

  register = function(self, listener)
    --- @type list
    local listeners

    if listener.event == 'ADDON_LOADED' then
      --#region: ?
      -- ?
      --#endregion

      local addon_name = listener.owner.id
      local addons = self.listeners:get('ADDON_LOADED') --[[@as map]]

      if not addons:has(addon_name) then
        addons:set(addon_name, list())
      end

      listeners = addons:get(addon_name) --[[@as list]]
    end

    if listener.event ~= 'ADDON_LOADED' then
      --#region: ?
      -- ?
      --#endregion

      --#todo: ...
    end

    --#region: ?
    -- ?
    --#endregion

    listeners:insert(
      {
        owner = listener.owner,
        callback = listener.callback,
        identifier = listener.identifier,
        recurring = (listener.recurring == true)

      } --[[@as events.listener]]
    )
  end,

  --
  -- ?
  --

  unregister = function(self, listener) end,

  --
  -- ?
  --

  invoke = function(self, event, ...)
    --#region: ?
    -- ?
    --#endregion

    if event == 'ADDON_LOADED' then
      --- @type string
      local addon = ...
    end

    --#region: ?
    -- ?
    --#endregion

    if event ~= 'ADDON_LOADED' then end
  end
}

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

    listen = function(self, listener) end,

    --
    -- ?
    --

    silence = function(self, listener) end

  } --[[@as events.API]]
}

--
-- ?
--

--- @type plugin.initialize
local initialize = function(self, callback)
  self.event:listen({ event = 'ADDON_LOADED', callback = callback })
end

--
-- ?
--

network:monitor(
  plugin, 'PLUGIN_ADDED',
  {
    callback = function(payload)
      --- @cast payload plugin.added.payload

      local target = payload.plugin

      target.event = setmetatable({ parent = target }, event_api)
      target.initialize = initialize
    end
  }
)

--
-- ?
--

frame:register_event_handler(
  function(event, ...)
    event_handler:invoke(event, ...)
  end
)

--
-- ?
--

context:export('module/events', event_handler)
