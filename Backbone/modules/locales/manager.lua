--[[~ Module: Locales ~
  Updated: 2024/10/21 | Author(s): Erik Riklund (Gopher)
]]

---@type table<string, Locale>
local locales = {}
local currentLocale = GetLocale()

---
--- Registers a set of localized strings for the specified namespace and locale.
---
---@param namespace string
---@param locale string
---@param strings LocalizedStrings
---
backbone.registerLocalizedStrings = function(namespace, locale, strings)
  locales[namespace] = locales[namespace] or {}
  locales[namespace][locale] = locales[namespace][locale] or {}

  backbone.utilities.integrateTable(locales[namespace][locale], strings)
end

---
--- Retrieves a localized string by key from the specified namespace.
--- Falls back to `enUS` if the current locale is not available.
---
---@param namespace string
---@param key string
---
backbone.getLocalizedString = function(namespace, key)
  if not locales[namespace] then
    return string.format('No strings registered for namespace "%s".', namespace)
  end

  ---@type LocalizedStrings?
  local strings = locales[namespace][currentLocale] or locales[namespace].enUS
  return (type(strings) == 'table' and strings[key])
    or string.format('Missing localized string "%s" in namespace "%s".', key, namespace)
end
