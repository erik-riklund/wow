---@type string, Repository
local addon, repository = ...

--[[~ Module: Locales ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

]]

local locales = {}
local currentLocale = GetLocale()
local fallbackLocale = 'enUS'

---
--- ?
---
---@param plugin string
---@param locale string
---@param content hashmap<string, string>
---@param useAsFallback? boolean
---
backbone.registerLocale = function(plugin, locale, content, useAsFallback)
  if locales[plugin] == nil then locales[plugin] = {} end
  if locales[plugin][locale] == nil then locales[plugin][locale] = {} end
  if useAsFallback == true then fallbackLocale = locale end

  backbone.utilities.integrateTable(locales[plugin][locale], content)
end

---
--- ?
---
---@param plugin string | Plugin
---@param key string
---
---@return string
---
backbone.getLocalizedString = function(plugin, key)
  plugin = (type(plugin) == 'table' and plugin.identifier) or string.lower(plugin --[[@as string]])

  if locales[plugin] == nil then
    backbone.throwError('The plugin "%s" have no registered locales.', plugin) --
  end

  ---@type table?
  local locale = locales[plugin][currentLocale] or locales[plugin][fallbackLocale]
  return (type(locale) == 'table' and locale[key]) --
    or string.format('[Missing localized string "%s" (%s)]', key, plugin)
end

---
--- ?
---
---@type LocalesApi
---
local api = {
  getLocalizedString = function(self, key)
    return backbone.getLocalizedString(self, key) --
  end,
}

---
---
---
repository.registerListener(
  'PLUGIN_ADDED',
  'LOCALES_API_INTEGRATION',
  ---@param plugin Plugin
  function(plugin) backbone.utilities.integrateTable(plugin, api) end
)
