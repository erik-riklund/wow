---@class Backbone
local context = select(2, ...)

--[[~ Module: Configuration Manager ~
  Updated: 2024/10/28 | Author(s): Erik Riklund (Gopher)
]]

---
--- Manages the configuration settings for a plugin, allowing for dynamic
--- access to account or character-specific variables.
---
---@class ConfigManager
---
local configManager = {}

---
--- The current scope of the configuration manager, determining
--- whether it uses account-level or character-level settings.
---
---@protected
---@type 'account'|'character'
---
configManager.scope = nil

---
--- A collection of configuration handlers for both account and character scopes,
--- facilitating access to their respective settings.
---
---@protected
---@type table<'account'|'character', ConfigHandler>
---
configManager.handlers = nil

---
--- Sets the scope of the configuration manager.
---
---@param scope 'account'|'character'
---
configManager.setScope = function(self, scope) self.scope = scope end

---
--- Retrieves the value of a specified configuration variable based on the current scope.
---
---@param path string
---
configManager.getVariable = function(self, path)
  return self.handlers[self.scope]:getValue(path) --
end

---
--- Sets the value of a specified configuration variable in the current scope.
---
---@param path string
---@param value unknown
---
configManager.setVariable = function(self, path, value)
  self.handlers[self.scope]:setValue(path, value) --
end

---
--- Creates and initializes a new configuration manager instance for a plugin,
--- setting up handlers for account and character configurations.
---
---@param plugin Plugin
---@param defaults table
---
---@return ConfigManager
---
backbone.useConfigManager = function(plugin, defaults)
  defaults.useAccountVariables = true
  local defaultsStorageUnit = backbone.components.createStorageUnit(defaults)

  local account = backbone.components.createConfigHandler( --
    plugin,
    context.getStorageUnit(plugin, 'account'),
    defaultsStorageUnit
  )
  local character = backbone.components.createConfigHandler( --
    plugin,
    context.getStorageUnit(plugin, 'character'),
    defaultsStorageUnit
  )

  local manager = {
    handlers = { account = account, character = character },
    scope = ((account:getValue 'useAccountVariables' == true and 'account') or 'character'),
  }

  return backbone.utilities.inheritParent(manager, configManager)
end
