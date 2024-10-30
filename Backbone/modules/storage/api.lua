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
--- Retrieves the value for the given `path` from the persistent account storage.
---
---@param self Plugin
---@param path string
---@return unknown
---
api.getAccountVariable = function(self, path)
  return context.getStorageUnit(self, 'account'):getEntry(path) --
end

---
--- Sets the value for the given `path` in the persistent account storage.
---
---@param self Plugin
---@param path string
---@param value unknown
---
api.setAccountVariable = function(self, path, value)
  context.getStorageUnit(self, 'account'):setEntry(path, value) --
end

---
--- Retrieves the value for the given `path` from the persistent character storage.
---
---@param self Plugin
---@param path string
---@return unknown
---
api.getCharacterVariable = function(self, path)
  return context.getStorageUnit(self, 'character'):getEntry(path) --
end

---
--- Sets the value for the given `path` in the persistent character storage.
---
---@param self Plugin
---@param path string
---@param value unknown
---
api.setCharacterVariable = function(self, path, value)
  context.getStorageUnit(self, 'character'):setEntry(path, value) --
end

---
--- Integrates the storage API into new plugins, and schedules the initialization
--- of the storage units to be executed once the plugin have been loaded.
---
context.apis[#context.apis + 1] = function(plugin, options)
  if options and options.storage then
    plugin:onLoad(function()
      for _, scope in ipairs { 'account', 'character' } do
        if options.storage[scope] then context.setupStorageUnit(plugin, scope) end
      end
    end)
  end

  backbone.utilities.integrateTable(plugin, api)
end
