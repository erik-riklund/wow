--[[~ Module: Storage ~
  Updated: 2024/10/23 | Author(s): Erik Riklund (Gopher)
]]

---@class Backbone
local context = select(2, ...)

local getStorageUnit = context.getStorageUnit
local setupStorageUnit = context.setupStorageUnit

---@type StorageApi
local api = {
  --
  getAccountVariable = function(self, path)
    return getStorageUnit(self, 'account'):getEntry(path)
  end,
  --
  getCharacterVariable = function(self, path)
    return getStorageUnit(self, 'character'):getEntry(path)
  end,
  --
  setAccountVariable = function(self, path, value)
    getStorageUnit(self, 'account'):setEntry(path, value)
  end,
  --
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
