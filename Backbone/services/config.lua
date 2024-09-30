---@type string, contextProvider
local addon, repository = ...
local api = repository.use 'api' --[[@as api]]

---@type storage.unitConstructor
local createStorageUnit = repository.use 'storage-unit'

--[[~ Service: Configuration Manager ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/30

  Provides functionality for managing configuration settings at both character 
  and account levels. It supports retrieving, setting, and validating settings 
  with defaults. Settings are applied based on the 'useCharacterProfile' flag 
  to differentiate between character-specific and account-wide configurations.

  Features:

  - Supports default values for settings.
  - Handles settings on both character and account levels.
  - Validates settings using xtype to ensure type safety.

]]

local prefix = '__config/'

---@type configHandler
local handler = {
  -- Returns the value of the specified setting, falling back to a default if
  -- undefined. Handles whether the setting applies to a character or account
  -- based on 'useCharacterProfile'.

  getSetting = function(self, identifier)
    if identifier == 'useCharacterProfile' then
      -- Retrieves the 'useCharacterProfile' setting, falling back to the default
      -- if it's not defined for the account.

      local useCharacterProfile = self.context:getAccountVariable(prefix .. identifier)
      if useCharacterProfile == nil then
        return self:getDefaultSetting(identifier) -- Fallback to default if not set.
      end

      return useCharacterProfile
    else
      -- Retrieves the setting for the given identifier. If 'useCharacterProfile'
      -- is true, the setting is retrieved from the character's profile; otherwise,
      -- it is retrieved from the account's profile.

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

      -- Returns the default value for the setting if no stored value exists.

      local defaultSetting = self:getDefaultSetting(identifier) -- Fallback to default if not set.

      if defaultSetting == nil then
        throw('No default setting found for "%s" (%s).', identifier, self.context.identifier)
      end

      return defaultSetting
    end
  end,

  -- Returns the default setting for the specified identifier by retrieving the
  -- corresponding entry from the defaults table.

  getDefaultSetting = function(self, identifier) return self.defaults:getEntry(identifier) end,

  -- Sets a new value for the specified setting, ensuring that it matches the
  -- type of the default value. Throws an error if no default is defined or if
  -- the value type is invalid.

  setSetting = function(self, identifier, value)
    xtype.validate { { 'identifier:string', identifier } }

    -- Retrieves the default setting for the identifier, validating its type. If
    -- no default is defined, an error is thrown.

    local defaultSetting = self:getDefaultSetting(identifier)
    local defaultSettingType = xtype.examine(defaultSetting)

    if defaultSettingType == 'undefined' then
      throw('No default setting defined for "%s" (%s).', identifier, self.context.identifier)
    end

    -- Validates that the provided value matches the type of the default setting.
    -- Throws an error if the types do not match.

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

    -- Stores the setting at the account level if 'useCharacterProfile' is false,
    -- otherwise stores it at the character level.

    if identifier == 'useCharacterProfile' then
      self.context:setAccountVariable(identifier, value)
    else
      -- Determines the scope for storing the setting based on 'useCharacterProfile'.
      -- If true, the setting is stored for the character, otherwise for the account.

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

-- Creates the configuration handler, setting default values and applying xtype
-- validation to ensure proper types are used. Returns a new handler instance
-- with the provided context and defaults.

---@type configService
local createHandler = function(context, defaults)
  xtype.validate { { 'defaults:table', defaults } }

  defaults.useCharacterProfile = false -- Default setting: use account-level profiles.
  return inheritParent({ context = context, defaults = createStorageUnit(defaults) }, handler)
end

-- Registers the configuration manager service within the API, making it
-- available for other components to use.

api.provideService('config', createHandler)
