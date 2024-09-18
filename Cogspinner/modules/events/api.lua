--
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, framework
local addon, framework = ...

--- @type events.handler
local events = framework.import('events/handler')

--- @type network.controller
local network = framework.import('network/controller')

---
--- A prototype object enabling plugin interaction with game events,
--- with a focus on initialization and general event handling.
---
--- @type events.api
---
local api = {
  --
  -- Registers a callback function for one-time execution upon loading the associated addon.
  --
  onInitialize = function(self, callback)
    events.registerListener('ADDON_LOADED:' .. self.identifier,
                            { callback = callback, recurring = false })
  end,

  --
  -- Registers a listener to any event (excluding 'ADDON_LOADED'),
  -- associating it with the plugin's context.
  --
  registerEventListener = function(self, event, listener)
    if event == 'ADDON_LOADED' then
      throw('Use `onInitialize` to register listeners for "ADDON_LOADED"')
    end

    events.registerListener(event, listener, self)
  end,

  --
  -- Removes a listener for any specified event except 'ADDON_LOADED',
  -- using its identifier and the plugin's context.
  --
  removeEventListener = function(self, event, identifier)
    if event == 'ADDON_LOADED' then
      throw('Unable to remove listeners for "ADDON_LOADED"')
    end

    events.removeListener(event, identifier, self)
  end
}

--
-- A listener triggered when a new plugin is added to the system. It extends
-- the plugin's capabilities by adding methods for handling events. These methods
-- include initialization, event listening, and event removal.
--
network.registerListener('PLUGIN_ADDED', {
  --- @param plugin plugin
  callback = function(plugin)
    -- Inherit the methods from the events API prototype.
    integrateTable(plugin, api)
  end
})
