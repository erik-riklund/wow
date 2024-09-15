--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, framework.context
local addon, framework = ...

-- #region << imports >>
--- @type network.controller
local network = framework.import('network/controller')
--- @type storage.manager
local storage = framework.import('storage/manager')
-- #endregion

---
--- ?
---
--- @type storage.api
---
local api = {
  --
  -- ?
  --
  getAccountVariable = function(self, identifier)
    ---@diagnostic disable-next-line: missing-return
  end,

  --
  -- ?
  --
  setAccountVariable = function(self, identifier, value) end,

  --
  -- ?
  --
  getCharacterVariable = function(self, identifier)
    ---@diagnostic disable-next-line: missing-return
  end,

  --
  -- ?
  --
  setCharacterVariable = function(self, identifier, value) end
}

--
-- ?
--
network.registerListener('PLUGIN_ADDED', {
  --- @param plugin plugin
  --- @param options plugins.createPlugin.options
  callback = function(plugin, options)
    -- ?
    integrateTable(plugin, api)

    -- ?
    if type(options.variables) == 'table' then
      for index, level in ipairs({ 'account', 'character' }) do
        if notEmptyString(options.variables[level]) then
          local variable = options.variables[level]
          
          plugin:onInitialize(function()
            storage.setupStorageUnit(plugin, variable)
          end)
        end
      end
    end
  end
})
