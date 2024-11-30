---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/11/30 | Author(s): Gopher ]]

local config_prefix = '__config'
local default_settings = new 'Dictionary'

---@param path string
---?
local splitPath = function (path)
  local parents = split (path, '/')
  local variable = parents:removeElement()

  return parents, variable
end

---@class Plugin
local config_api = {}

context.registerPluginExtension(
  function (plugin) integrateTable (plugin, config_api) end
)

---@param settings table
---Registers default settings for the plugin.
config_api.registerDefaultSettings = function (self, settings)
  local identifier = self:getIdentifier()
  if default_settings:hasEntry (identifier) then
    backbone.throw ('Cannot register duplicate default settings (%s)', identifier)
  end

  default_settings:setEntry (identifier, settings)
end

---@param path string
---@return unknown?
---?
config_api.getDefaultSetting = function (self, path)
  local identifier = self:getIdentifier()

  ---@type table?
  local settings = default_settings:getEntry (identifier)
  if not settings then
    backbone.throw ('No default settings registered (%s)', identifier)
  end

  ---@cast settings table
  local parents, variable = splitPath (path)
  local value = (parents:getSize() > 0 and traverseTable (settings, parents)) or settings[variable]

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
    local parents, variable = splitPath (path)
    local setting = (parents:getSize() > 0 and traverseTable (settings, parents)) or settings[variable]
    
    if setting ~= nil then return setting end -- return the stored setting.
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

  local parents, variable = splitPath (path)
  settings = (parents:getSize() and traverseTable (settings, parents, 'build')) or settings
  settings[variable] = value -- updates the internal config table by reference.
end
