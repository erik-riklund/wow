---@type string, contextProvider
local addon, repository = ...
local api = repository.use 'api' --[[@as api]]

---@type storage.unitConstructor
local createStorageUnit = repository.use 'storage-unit'

--[[~ Service: Configuration Manager ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/27

  This service manages configuration settings for both account-wide and character-specific
  profiles. It allows the retrieval, modification, and storage of configuration settings,
  supporting default values and profile scoping.

  Features:

  - Manage account-wide and character-specific configuration settings.
  - Support default values for all configuration settings.
  - Dynamically select between account and character profiles based on user preferences.

  Dependencies: Storage Unit (component)

]]

local prefix = '__config/'

---@type configHandler
local handler = {
  getSetting = function(self, identifier)
    if identifier == 'useCharacterProfile' then
      -- Check if the 'useCharacterProfile' setting is stored in the account profile.

      local useCharacterProfile = self.context:getAccountVariable(prefix .. identifier)
      if useCharacterProfile == nil then
        return self:getDefaultSetting(identifier) -- Fallback to default if not set.
      end

      return useCharacterProfile -- Return the stored value.
    else
      -- For other settings, determine whether to use character or account scope.

      local useCharacterProfile = self:getSetting 'useCharacterProfile'
      local scope = (useCharacterProfile == true and 'character') or 'account'

      local setting
      if scope == 'character' then
        setting = self.context:getCharacterVariable(prefix .. identifier)
      else
        setting = self.context:getAccountVariable(prefix .. identifier)
      end

      if setting ~= nil then
        return setting -- Return the stored value.
      end

      return self:getDefaultSetting(identifier) -- Fallback to default if not set.
    end
  end,

  getDefaultSetting = function(self, identifier)
    return self.defaults:getEntry(identifier)
  end,

  setSetting = function(self, identifier, value)
    xtype.validate { { 'identifier:string', identifier } }

    local defaultSetting = self:getDefaultSetting(identifier)
    local defaultSettingType = xtype.examine(defaultSetting)

    if defaultSettingType == 'undefined' then
      throw('No default setting defined for "%s" (%s).', identifier, self.context.identifier)
    end

    local typesMatch, valueType = xtype.compare(value, defaultSettingType)
    if not typesMatch then
      throw(
        'Invalid value type for setting "%s" (%s). Expected %s, got %s.',
        identifier,
        self.context.identifier,
        defaultSettingType,
        valueType
      )
    end

    if identifier == 'useCharacterProfile' then
      self.context:setAccountVariable(identifier, value)
    else
      -- Determine the scope (character or account) based on `useCharacterProfile`.

      local useCharacterProfile = self:getSetting 'useCharacterProfile'
      local scope = (useCharacterProfile == true and 'character') or 'account'

      if scope == 'character' then
        self.context:setCharacterVariable(prefix .. identifier, value)
      else
        self.context:setAccountVariable(prefix .. identifier, value)
      end
    end
  end,
}

---@type configService
local createHandler = function(context, defaults)
  xtype.validate { { 'defaults:table', defaults } }

  defaults.useCharacterProfile = false -- Default to account-level profiles.
  return inheritParent({ context = context, defaults = createStorageUnit(defaults) }, handler)
end

-- Register the service:
api.provideService('config', createHandler)
