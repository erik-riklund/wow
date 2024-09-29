---@type string, contextProvider
local addon, repository = ...
local api = repository.use 'api' --[[@as api]]

---@type storage.unitConstructor
local createStorageUnit = repository.use 'storage-unit'

--[[~ Service: Configuration Manager ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/28

  This service manages configuration settings for plugins, supporting both account-wide and 
  character-specific profiles. It allows retrieval and modification of settings while handling 
  default values and profile scope (account or character).

  Features:

  - Retrieve and set configuration settings based on scope.
  - Use default values when settings are not explicitly defined.
  - Support account-level and character-specific profiles.

  Dependencies: Storage Unit (component)

]]

local prefix = '__config/'

---@type configHandler
local handler = {
  --
  -- getSetting()
  --
  -- This function retrieves a configuration setting based on the identifier. If the setting
  -- is `useCharacterProfile`, it retrieves the account-level profile. For other settings, it
  -- determines whether to use the account or character profile based on the `useCharacterProfile`
  -- value. If no value is found, it returns the default setting.
  --

  getSetting = function(self, identifier)
    if identifier == 'useCharacterProfile' then
      --
      -- Retrieve the 'useCharacterProfile' setting from the account profile. If the setting
      -- is not found, return the default value for this setting.

      local useCharacterProfile = self.context:getAccountVariable(prefix .. identifier)
      if useCharacterProfile == nil then
        return self:getDefaultSetting(identifier) -- Fallback to default if not set.
      end

      return useCharacterProfile
    else
      -- If the identifier is not 'useCharacterProfile', determine the scope (account or
      -- character) based on the value of 'useCharacterProfile'. Retrieve the setting from
      -- the appropriate scope and return it if available.

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

      -- If the setting is not found in the chosen scope, return the default value for the
      -- setting. If the default value does not exist, throw an error.

      local defaultSetting = self:getDefaultSetting(identifier) -- Fallback to default if not set.

      if defaultSetting == nil then
        throw('No default setting found for "%s" (%s).', identifier, self.context.identifier)
      end

      return defaultSetting
    end
  end,

  --
  -- getDefaultSetting()
  --
  -- This function retrieves the default setting for the specified identifier. Default settings
  -- are stored in a separate storage unit, and this function ensures that a value is always
  -- returned, even if no custom setting has been defined.
  --

  getDefaultSetting = function(self, identifier)
    return self.defaults:getEntry(identifier)
  end,

  --
  -- setSetting()
  --
  -- This function sets a configuration setting based on the provided identifier and value.
  -- It first validates the value against the default setting type to ensure that the correct
  -- data type is being used. Depending on whether `useCharacterProfile` is set to true, the
  -- setting is stored either in the account or character profile.
  --

  setSetting = function(self, identifier, value)
    xtype.validate { { 'identifier:string', identifier } }

    -- Retrieve the default setting for comparison and validation. If the setting is not
    -- defined in the defaults, an error is thrown, indicating that no valid setting exists.

    local defaultSetting = self:getDefaultSetting(identifier)
    local defaultSettingType = xtype.examine(defaultSetting)

    if defaultSettingType == 'undefined' then
      throw('No default setting defined for "%s" (%s).', identifier, self.context.identifier)
    end

    -- Compare the provided value with the expected type of the default setting. If the types
    -- do not match, an error is thrown, indicating that the wrong type has been used for this
    -- configuration setting.

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

    -- If `useCharacterProfile` is being set, store the value in the account profile. For other
    -- settings, determine the correct scope (account or character) based on `useCharacterProfile`.

    if identifier == 'useCharacterProfile' then
      self.context:setAccountVariable(identifier, value)
    else
      -- Determine the correct profile scope and set the value in either the account or
      -- character profile, depending on the `useCharacterProfile` setting.

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

--
-- createHandler()
--
-- This function creates a configuration handler by linking it to the plugin's context and default
-- settings. The handler allows the plugin to retrieve and set configuration values, ensuring that
-- account and character profiles are supported. Default settings are initialized when the handler
-- is created.
--

---@type configService
local createHandler = function(context, defaults)
  xtype.validate { { 'defaults:table', defaults } }

  defaults.useCharacterProfile = false -- Default setting: use account-level profiles.
  return inheritParent({ context = context, defaults = createStorageUnit(defaults) }, handler)
end

-- Register the configuration service with the API, making it available to other components and plugins.
-- The service provides functionality to manage configuration settings for both account-wide and character-specific profiles.

api.provideService('config', createHandler)
