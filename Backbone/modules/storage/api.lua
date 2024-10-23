---@class Backbone
local context = select(2, ...)

--[[~ Module: Storage ~
  Updated: 2024/10/23 | Author(s): Erik Riklund (Gopher)
]]

local getStorageUnit = context.getStorageUnit
local setupStorageUnit = context.setupStorageUnit

---
--- Defines the API for managing storage variables for plugins.
---
---@class StorageApi
---
local api = {
  ---
  --- Retrieves the value of an account variable based on the given path.
  ---
  ---@param self Plugin
  ---@param path string
  ---@return unknown
  ---
  getAccountVariable = function(self, path)
    return getStorageUnit(self, 'account'):getEntry(path)
  end,

  ---
  --- Retrieves the value of a character variable based on the given path.
  ---
  ---@param self Plugin
  ---@param path string
  ---@return unknown
  ---
  getCharacterVariable = function(self, path)
    return getStorageUnit(self, 'character'):getEntry(path)
  end,

  ---
  --- Sets the value of an account variable at the specified path.
  ---
  ---@param self Plugin
  ---@param path string
  ---@param value unknown
  ---
  setAccountVariable = function(self, path, value)
    getStorageUnit(self, 'account'):setEntry(path, value)
  end,

  ---
  --- Sets the value of a character variable at the specified path.
  ---
  ---@param self Plugin
  ---@param path string
  ---@param value unknown
  ---
  setCharacterVariable = function(self, path, value)
    getStorageUnit(self, 'character'):setEntry(path, value)
  end,
}

---
--- Integrate the storage API into new plugins, and initialize
--- the storage units once the plugin have been loaded.
---
backbone.registerChannelListener(context.plugin, 'PLUGIN_ADDED', {
  ---@param plugin Plugin
  ---@param options PluginOptions
  callback = function(plugin, options)
    if type(options) == 'table' and type(options.storage) == 'table' then
      for scope, variable in pairs(options.storage) do
        plugin:onLoad(function() setupStorageUnit(plugin, scope, variable) end)
      end
    end

    backbone.utilities.integrateTable(plugin, api)
  end,
})
