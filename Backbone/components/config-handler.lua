--[[~ Component: Configuration Handler ~
  Updated: 2024/10/24 | Author(s): Erik Riklund (Gopher)
]]

local prefix = '__backbone/config/'

---
--- Manages configuration settings for a plugin profile.
---
---@class ConfigHandler
---
local configHandler = {}

---
--- The plugin associated with the configuration handler.
---
---@protected
---@type Plugin
---
configHandler.plugin = nil

---
--- The storage unit containing the current configuration settings for the profile.
---
---@protected
---@type StorageUnit
---
configHandler.storage = nil

---
--- The storage unit containing the default configuration settings for the profile.
---
---@protected
---@type StorageUnit
---
configHandler.defaults = nil

---
--- Sets the storage unit for the configuration handler.
---
---@param storage StorageUnit
---
configHandler.setStorage = function(self, storage) self.storage = storage end

---
--- Retrieves the value of a specified configuration option from the storage and 
--- default units. Throws an exception if the option is not found.
---
---@param path string
---
configHandler.getValue = function(self, path)
  for index, storage in ipairs { self.storage, self.defaults } do
    local value = storage:getEntry(((index == 1 and prefix) or '') .. path)
    if value ~= nil then return value end
  end

  local exception = 'Failed to retrieve configuration option "%s" (%s)'
  backbone.throwException(exception, path, self.plugin.name)
end

---
--- Sets the value of a specified configuration option in the storage unit, ensuring 
--- that the option exists in the defaults. Throws an exception if it does not.
---
---@param path string
---@param value unknown
---
configHandler.setValue = function(self, path, value)
  if self.defaults:getEntry(path) == nil then
    local exception = 'Unknown configuration option "%s" (%s)'
    backbone.throwException(exception, path, self.plugin.name)
  end

  self.storage:setEntry(prefix .. path, value)
end

---
--- Creates and returns a new configuration handler instance associated with
--- the specified plugin, with storage units for settings and defaults.
---
---@param plugin Plugin
---@param storage StorageUnit
---@param defaults StorageUnit
---
---@return ConfigHandler
---
backbone.components.createConfigHandler = function(plugin, storage, defaults)
  local handler = { plugin = plugin, storage = storage, defaults = defaults }
  return backbone.utilities.inheritParent(handler, configHandler)
end
