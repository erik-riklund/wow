---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/12/04 | Author(s): Gopher ]]

--Backbone - A World of Warcraft Addon Framework
--Copyright (C) 2024 Erik Riklund (Gopher)
--
--This program is free software: you can redistribute it and/or modify it under the terms
--of the GNU General Public License as published by the Free Software Foundation, either
--version 3 of the License, or (at your option) any later version.
--
--This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
--without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
--See the GNU General Public License <https://www.gnu.org/licenses/> for more details.

local locales = new 'Dictionary'

---@param plugin Plugin
---@param key string
---@return string
local getLocalizedString = function (plugin, key)
  if locales:hasEntry (plugin) then
    local registeredLocales = locales:getEntry (plugin) --[[@as table]]

    if registeredLocales[backbone.activeLocale] then
      local strings = registeredLocales[backbone.activeLocale] --[[@as table]]
      if strings[key] then return strings[key] end -- returns the registered string.
    end

    if registeredLocales.enUS then
      local strings = registeredLocales.enUS --[[@as table]]
      if strings[key] then return strings[key] end -- returns the registered string.
    end
  end

  return string.format('Missing localized string: %s (%s)', key, plugin:getName())
end

---@param plugin Plugin
---@param locale LocaleCode
---@param strings table
local registerLocalizedStrings = function (plugin, locale, strings)
  if not locales:hasEntry (plugin) then
    locales:setEntry (plugin, new 'Dictionary')
  end
  if not locales:getEntry (plugin):hasEntry (locale) then
    locales:getEntry (plugin):setEntry (locale, {})
  end

  integrateTable (locales:getEntry (plugin):getEntry (locale), strings)
end

--- PLUGIN API ---

---@class Plugin
local localesApi = context.pluginApi

---@param key string
--- Retrieves the localized string for the specified key.
localesApi.getLocalizedString = function (self, key)
  return getLocalizedString (self, key)
end

---@param locale LocaleCode
---@param strings table
---Registers localized strings for the specified locale.
localesApi.registerLocalizedStrings = function (self, locale, strings)
  registerLocalizedStrings (self, locale, strings)
end
