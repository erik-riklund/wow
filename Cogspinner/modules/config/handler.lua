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
--- ?
---
--- @param path string
---
local createConfigPath = function(path)
  return '__config/' .. path
end

---
--- ?
--- 
--- @param context plugin
---
local useCharacterSettings = function(context)
  local unit = storage.getStorageUnit(context, 'account')
  return (unit:getVariable(createConfigPath('useCharacterSettings')) == true)
end

---
--- ?
--- 
--- @type table<string, table>
---
local defaultSettings = {}

---
--- ?
--- 
--- @param context plugin
--- @param identifier string
--- 
--- @return unknown?
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
--- ?
--- 
--- @type config.handler
---
handler = {
  --
  getSetting = function(context, identifier)
    if defaultSettings[context.identifier] == nil then
      throw('No default settings have been registered for plugin "%s"', context.identifier)
    end

    local scopes = { 'character', 'account', 'default' }
    if not useCharacterSettings(context) then table.remove(scopes, 1) end

    for index, scope in ipairs(scopes) do
      if scope ~= 'default' then
        -- ?

        local unit = storage.getStorageUnit(context, scope)
        local value = unit:getVariable(createConfigPath(identifier))

        if value ~= nil then return value end -- stops the execution.
      end

      return getDefaultSetting(context, identifier)
    end
  end,

  --
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

  --
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
