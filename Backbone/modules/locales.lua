---@type string, contextProvider
local addon, repository = ...
local plugin = repository.use 'plugin-api' --[[@as plugin]]

--[[~ Module: Localization Manager ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/27

  This module handles the registration and retrieval of localized strings for plugins. 
  It supports fallback locales if the game locale is not available.

  Features:

  - Register localized strings for different locales.
  - Retrieve localized strings based on the current game locale.
  - Support for fallback locale.

]]

---@type table<plugin, table<string, table>>
local locales = {}
local gameLocale = GetLocale()

--
-- getLocalizedString()
--
-- This function retrieves a localized string for the specified identifier. It first checks whether
-- the string is available for the current game locale. If not, it attempts to fetch the string from
-- the fallback locale, if one is defined. If the string is not found in either, the function returns
-- a formatted error string indicating the missing localization.
--

plugin.getLocalizedString = function(self, identifier)
  xtype.validate { { 'identifier:string', identifier } }

  if type(locales[self.identifier]) ~= 'table' then
    throw('No locales registered for plugin "%s".', self.identifier)
  end

  -- Attempt to retrieve the string from the current game locale, then fallback to
  -- the fallback locale if it's defined. If neither is available, return an error message.

  return locales[self.identifier][gameLocale][identifier]
    or (
      type(locales[self.identifier]['fallback']) == 'function'
      and locales[self.identifier]['fallback'][identifier] --[[@as string]]
    )
    or string.format('[Missing localized string "%s" (%s)]', identifier, self.identifier)
end

--
-- registerLocale()
--
-- This function registers a new locale for the plugin, including the localized content. It validates
-- the provided data and ensures that the locale identifier, the localized content, and the optional
-- fallback flag are valid. If the `fallback` flag is set to true, the content is also registered as
-- the fallback locale. If a locale or fallback is already registered for this plugin, the function
-- throws an error to prevent overwriting.
--

plugin.registerLocale = function(self, data)
  locales[self.identifier] = locales[self.identifier] or {}

  xtype.validate {
    { 'data:table', data },
    { 'data.locale:string', data.locale },
    { 'data.content:table', data.content },
    { 'data.fallback:boolean?', data.fallback },
  }

  -- If the locale is already registered for this plugin, throw an error
  -- to prevent re-registration of the same locale.

  if locales[self.identifier][data.locale] ~= nil then
    throw('Locale "%s" is already registered (%s).', data.locale, self.identifier)
  end

  locales[self.identifier][data.locale] = data.content

  -- If the `fallback` flag is set to `true`, the function registers this locale
  -- as the fallback locale. If a fallback locale is already registered, an error
  -- is thrown to avoid overwriting the existing fallback.

  if data.fallback == true then
    if locales[self.identifier]['fallback'] ~= nil then
      throw('A fallback locale is already registered (%s).', self.identifier)
    end

    locales[self.identifier]['fallback'] = data.content
  end
end
