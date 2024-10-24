---@class Backbone
local context = select(2, ...)

--[[~ Module: Storage ~
  Updated: 2024/10/24 | Author(s): Erik Riklund (Gopher)
]]

---
--- Defines the API for managing storage variables for plugins.
---
---@class StorageApi
---
local api = {}

---
--- Retrieves the value for the given `path` from the persistent storage.
---
---@param self Plugin
---@param path string
---@return unknown
---
api.getStorageVariable = function(self, path)
  return context.getStorageUnit(self):getEntry(path)
end

---
--- Sets the value for the given `path` in the persistent storage.
---
---@param self Plugin
---@param path string
---@param value unknown
---
api.setStorageVariable = function(self, path, value)
  context.getStorageUnit(self):setEntry(path, value)
end

---
--- Integrate the storage API into new plugins, and initialize
--- the storage units once the plugin have been loaded.
---
backbone.registerChannelListener(context.plugin, 'PLUGIN_ADDED', {
  ---@param plugin Plugin
  ---@param options PluginOptions
  callback = function(plugin, options)
    if type(options) == 'table' and type(options.storage) == 'string' then
      plugin:onLoad(function() context.setupStorageUnit(plugin, options.storage) end)
    end

    backbone.utilities.integrateTable(plugin, api)
  end,
})
