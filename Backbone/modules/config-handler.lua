---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/11/30 | Author(s): Gopher ]]

local config_prefix = '__config'
local default_settings = new 'Dictionary'

---@class Plugin
local config_api = {}

context.registerPluginExtension(
  function (plugin) integrateTable (plugin, config_api) end
)

---@param settings table
---Registers a set of default settings for the plugin.
---* Throws an error if settings for the plugin are already registered.
config_api.registerDefaultSettings = function (self, settings)
  local identifier = self:getIdentifier()
  if default_settings:hasEntry (identifier) then
    backbone.throw ('Cannot register duplicate default settings (%s)', identifier)
  end

  default_settings:setEntry (identifier, flattenTable (settings))
end

---@param path string
---@return unknown?
---Retrieves a specific default setting for the plugin by its path.
---* Throws an error if no default settings are registered for the plugin.
---* Throws an error if the requested path does not exist in the default settings.
config_api.getDefaultSetting = function (self, path)
  local identifier = self:getIdentifier()

  ---@type table?
  local settings = default_settings:getEntry (identifier)
  if not settings then
    backbone.throw ('No default settings registered (%s)', identifier)
  end

  ---@cast settings table
  local value = settings[path]

  if value == nil then
    backbone.throw ('Unknown default setting "%s" requested (%s)', path, identifier)
  end

  return value
end

---@param path string
---@return unknown?
---Retrieves the value of a setting for the plugin.
---* Falls back to the default setting if no user-defined value is found.
---* Throws an error if the setting is unknown.
config_api.getSetting = function (self, path)
  local settings = self:getAccountVariable (config_prefix)
  
  if type (settings) == 'table' then
    local value = settings[path]
    if value ~= nil then return value end -- return the stored setting.
  end

  local default_setting = self:getDefaultSetting (path)
  if default_setting ~= nil then return default_setting end

  backbone.throw ('Unknown setting "%s" (%s)', path, self:getIdentifier())
end

---@param path string
---@param value unknown
---Updates the value of a setting for the plugin.
---* Validates that the new value matches the type of the default setting.
---* Throws an error if the setting is unknown or if the type mismatches.
config_api.setSetting = function (self, path, value)
  local identifier = self:getIdentifier()
  
  local default_setting = self:getDefaultSetting (path)
  if default_setting == nil then
    backbone.throw ('Unknown setting "%s" (%s)', path, identifier)
  end

  if type (value) ~= type (default_setting) then
    backbone.throw ('Type mismatch for setting "%s", expected %s (%s)',
                     path, type (default_setting), identifier)
  end

  local settings = self:getAccountVariable (config_prefix)
  if type (settings) ~= 'table' then
    self:setAccountVariable (config_prefix, {})
    settings = self:getAccountVariable (config_prefix)
  end

  settings[path] = value
end
