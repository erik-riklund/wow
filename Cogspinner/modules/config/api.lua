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

--- @type config.handler
local config = framework.import('config/handler')

--- @type network.controller
local network = framework.import('network/controller')

---
--- Implements the API for interacting with plugin configurations, 
--- providing methods to get, set, and register default settings for a plugin.
---
--- @type config.api
---
local api = {
  --- Retrieves the value of a specific setting by its identifier.
  getSetting = function(self, identifier)
    return config.getSetting(self, identifier)
  end,

  --- Sets or updates the value of a specific setting by its identifier.
  setSetting = function(self, identifier, value)
    config.setSetting(self, identifier, value)
  end,

  --- Registers a set of default settings for the plugin.
  setDefaultSettings = function(self, settings)
    config.registerDefaultSettings(self, settings)
  end
}

---
--- Registers a listener for the 'PLUGIN_ADDED' event, integrating the plugin API methods
--- and setting default settings (if provided in the plugin options).
---
network.registerListener('PLUGIN_ADDED', {
  --- @param plugin plugin
  --- @param options plugins.createPlugin.options
  callback = function(plugin, options)
    -- inherit the API methods.
    integrateTable(plugin, api)

    -- apply default settings if available.
    if type(options.config) == 'table' then plugin:setDefaultSettings(options.config) end
  end
})
