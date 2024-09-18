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
--- ?
---
--- @type config.api
---
local api = {
  --
  getSetting = function(self, identifier)
    return config.getSetting(self, identifier)
  end,

  --
  setSetting = function(self, identifier, value)
    config.setSetting(self, identifier, value)
  end,

  --
  setDefaultSettings = function(self, settings)
    config.registerDefaultSettings(self, settings)
  end
}

---
--- ?
---
network.registerListener('PLUGIN_ADDED', {
  --- @param plugin plugin
  --- @param options plugins.createPlugin.options
  callback = function(plugin, options)
    integrateTable(plugin, api) -- inherit the API methods.

    if type(options.config) == 'table' then
      plugin:setDefaultSettings(options.config)
    end
  end
})
