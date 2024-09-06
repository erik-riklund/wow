--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string, Context
local addon, framework = ...

local events           = framework.import('module/events') --[[@as EventHandler]]
local network          = framework.import('module/network') --[[@as Network]]

--
-- Provides methods for plugins to interact with events.
--
--- @type EventHandlerApi
--
local api              =
{
  --
  -- Registers a callback function to be executed once when the addon is fully loaded.
  --
  onInitialize = function(self, callback)
    events.registerListener(
      'ADDON_LOADED:' .. self.name,
      { callback = callback, recurring = false }
    )
  end,

  --
  -- Registers a listener function for a specific game event. Throws an exception if the
  -- event is 'ADDON_LOADED' as it's handled separately.
  --
  registerEventListener = function(self, event, listener)
    if event == 'ADDON_LOADED' then
      exception('Cannot register listeners for "ADDON_LOADED" using this method, use `onInitialize` instead.')
    end

    events.registerListener(event, listener, self.name)
  end,

  --
  -- Removes a previously registered event listener.
  --
  removeEventListener = function(self, event, identifier)
    events.removeListener(event, identifier, self.name)
  end
}

--
-- Integrates the events API into plugins during their creation.
--
network.registerListener(
  'PLUGIN_ADDED',
  {
    --- @param plugin Plugin
    callback = function(plugin)
      --~ Injects the event API methods into the plugin.

      plugin.onInitialize          = api.onInitialize
      plugin.registerEventListener = api.registerEventListener
      plugin.removeEventListener   = api.removeEventListener
    end
  }
)
