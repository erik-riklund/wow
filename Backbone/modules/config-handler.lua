---@class Backbone
local context = select(2, ...)

--[[~ Configuration handler (module) ~
  Updated: 2024/11/20 | Author(s): Erik Riklund (Gopher)
]]

local config_prefix = '__config/'

---
--- ?
---
local default_settings = new 'Dictionary'

---
--- ?
---
---@param plugin Plugin
---@param key string
---
local getDefaultSetting = function(plugin, key)
  ---@type Dictionary?
  local plugin_settings = default_settings:getEntry(plugin:getIdentifier())

  if not plugin_settings then
    new('Error', 'No default settings registered (%s)', plugin:getIdentifier())
  end

  return (plugin_settings --[[@as Dictionary]]):getEntry(key)
end

---
---@class Plugin
---
local config_api = {}

---
--- ?
---
---@param settings Dictionary
---
config_api.registerDefaultSettings = function(self, settings)
  if default_settings:hasEntry(self:getIdentifier()) then
    new('Error', 'Cannot register duplicate default settings (%s)', self:getIdentifier())
  end

  default_settings:setEntry(self:getIdentifier(), settings)
end

---
--- ?
---
---@param key string
---
config_api.getSetting = function(self, key)
  local setting = self:getAccountVariable(config_prefix .. key)
  if setting ~= nil then return setting end -- return the stored setting.

  local default_setting = getDefaultSetting(self, key)
  if default_setting ~= nil then return default_setting end

  new('Error', 'Unknown setting "%s" (%s)', key, self:getIdentifier())
end

---
--- ?
---
---@param key string
---@param value unknown
---
config_api.setSetting = function(self, key, value)
  local default_setting = getDefaultSetting(self, key)
  if default_setting == nil then
    new('Error', 'Unknown setting "%s" (%s)', key, self:getIdentifier())
  end

  if type(value) ~= type(default_setting) then
    new('Error', 'Type mismatch for setting "%s", expected %s (%s)',
        key, type(default_setting), self:getIdentifier())
  end

  self:setAccountVariable(config_prefix .. key, value)
end

---
--- ?
---
context.registerPluginExtension(
  function(plugin)
    plugin.getSetting = config_api.getSetting
    plugin.setSetting = config_api.setSetting

    plugin.registerDefaultSettings = config_api.registerDefaultSettings
  end
)