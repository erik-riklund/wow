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

--- @type network.controller
local network = framework.import('network/controller')

--- @type storage.manager
local storage = framework.import('storage/manager')

---
--- The API prototype object provides methods for plugins to interact with storage,
--- specifically for getting and setting variables at both the account and character levels.
---
--- @type storage.api
---
local api = {
  --
  getAccountVariable = function(self, identifier)
    return storage.getStorageUnit(self, 'account'):getVariable(identifier)
  end,

  --
  setAccountVariable = function(self, identifier, value)
    storage.getStorageUnit(self, 'account'):setVariable(identifier, value)
  end,

  --
  getCharacterVariable = function(self, identifier)
    return storage.getStorageUnit(self, 'character'):getVariable(identifier)
  end,

  --
  setCharacterVariable = function(self, identifier, value)
    storage.getStorageUnit(self, 'character'):setVariable(identifier, value)
  end
}

--
-- A listener triggered when a new plugin is added to the system. It extends the plugin's
-- capabilities by adding methods for interacting with storage. Additionally, it sets up
-- storage units based on the plugin's options.
--
network.registerListener('PLUGIN_ADDED', {
  --- @param plugin plugin
  --- @param options plugins.createPlugin.options
  callback = function(plugin, options)
    -- Inherit the methods from the API prototype.
    integrateTable(plugin, api)

    -- Initializes storage units for the plugin based on its configured options.
    if type(options.variables) == 'table' then
      for index, scope in ipairs({ 'account', 'character' }) do
        if notEmptyString(options.variables[scope]) then
          local variable = options.variables[scope] --[[@as string]]

          plugin:onInitialize(function()
            storage.setupStorageUnit(plugin, scope, variable)
          end)
        end
      end
    end
  end
})
