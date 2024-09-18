--
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, framework
local addon, framework = ...
local handler

--- @type storage.manager
local storage = framework.import('storage/manager')

--- @type library.resolveVariablePath
local resolveVariablePath = framework.import('library/resolve-path')

---
--- Creates a path for storing configuration variables.
--- @param path string The relative path for the configuration setting.
---
local createConfigPath = function(path)
  return '__config/' .. path
end

---
--- Determines if the plugin is using character-specific settings.
--- @param context plugin The plugin instance.
---
local useCharacterSettings = function(context)
  local unit = storage.getStorageUnit(context, 'account')
  return (unit:getVariable(createConfigPath('useCharacterSettings')) == true)
end

---
--- Centralized storage table where the default settings of each plugin is mapped to its unique identifier.
---
--- @type table<string, table>
---
local defaultSettings = {}

---
--- Retrieves the default value of a specific setting for a plugin.
---
--- @param context    plugin The plugin instance.
--- @param identifier string The unique identifier for the setting.
--- 
--- @return unknown? "The default value of the setting, or throws an error if the setting is not found."
---
local getDefaultSetting = function(context, identifier)
  local settings = defaultSettings[context.identifier]
  local parents, variable = resolveVariablePath(identifier)
  local source = (parents and traverseTable(settings, parents)) or settings

  if source[variable] == nil then
    throw('Unknown setting "%s" for plugin "%s"', identifier, context.identifier)
  end

  return source[variable]
end

---
--- The handler responsible for managing plugin configuration settings.
--- @type config.handler
---
handler = {
  ---
  --- Retrieves the value of a setting for a plugin, considering various scopes (character, account, default).
  --- It checks character-specific settings first if enabled, then falls back to account and default settings.
  ---
  getSetting = function(context, identifier)
    if defaultSettings[context.identifier] == nil then
      throw('No default settings have been registered for plugin "%s"', context.identifier)
    end

    local scopes = { 'character', 'account', 'default' }
    if not useCharacterSettings(context) then
      table.remove(scopes, 1)
    end

    for index, scope in ipairs(scopes) do
      if scope ~= 'default' then
        -- ?

        local unit = storage.getStorageUnit(context, scope)
        local value = unit:getVariable(createConfigPath(identifier))

        if value ~= nil then
          return value -- stops the execution.
        end
      end

      return getDefaultSetting(context, identifier)
    end
  end,

  ---
  --- Sets the value of a setting for a plugin, ensuring type consistency with the default setting.
  --- The setting is stored either in character or account scope, based on the plugin configuration.
  ---
  setSetting = function(context, identifier, value)
    if defaultSettings[context.identifier] == nil then
      throw('No default settings have been registered for plugin "%s"', context.identifier)
    end

    local defaultSetting = getDefaultSetting(context, identifier)
    local defaultSettingType = type(defaultSetting)

    if defaultSettingType ~= type(value) then
      throw(
       'Failed to set setting "%s" for plugin "%s" (mismatched types; expected "%s", recieved "%s")',
       identifier, context.identifier, defaultSettingType, type(value))
    end

    local scope = (useCharacterSettings(context) and 'character') or 'account'
    storage.getStorageUnit(context, scope):setVariable(createConfigPath(identifier), value)
  end,

  ---
  --- Registers default settings for a plugin and applies them to the account-wide storage unit.
  --- If no default settings have been previously registered, it initializes the plugin with the provided settings.
  ---
  registerDefaultSettings = function(context, settings)
    context:onInitialize(function()
      local unit = storage.getStorageUnit(context, 'account')

      if unit:getVariable(createConfigPath('useCharacterSettings')) == nil then
        -- the default behavior is to use account-wide settings.
        settings.useCharacterSettings = false

        -- when the default settings are registered for the first time,
        -- they are copied into the account-wide storage unit.
        integrateTable(unit.data, { __config = {} })
        integrateTable(unit.data.__config, settings)
      end

      -- register the default settings for the plugin if no settings
      -- have been previously provided.
      if defaultSettings[context.identifier] == nil then
        defaultSettings[context.identifier] = settings
      end
    end)
  end
}

--
framework.export('config/handler', handler)
