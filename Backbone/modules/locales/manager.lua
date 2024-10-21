--[[~ Module: Locales ~
  
  Author(s): Erik Riklund (Gopher)
  Updated: 2024/10/21
]]

---@type table<string, Locale>
local locales = {}
local currentLocale = GetLocale() -- TODO: implement custom locale settings.

---
--- Registers a set of localized strings for the specified namespace and locale.
---
---@param namespace string
---@param locale string
---@param localizedStrings LocalizedStrings
backbone.registerLocalizedStrings = function(namespace, locale, localizedStrings)
  locales[namespace] = locales[namespace] or {}
  locales[namespace][locale] = locales[namespace][locale] or {}

  backbone.utilities.integrateTable(locales[namespace][locale], localizedStrings)
end

---
--- Retrieves a localized string by key from the specified namespace.
--- Falls back to `enUS` if the current locale is not available.
---
---@param namespace string
---@param key string
backbone.getLocalizedString = function(namespace, key)
  if not locales[namespace] then
    return string.format('No strings registered for namespace "%s".', namespace)
  end

  ---@type LocalizedStrings?
  local localizedStrings = locales[namespace][currentLocale] or locales[namespace].enUS
  return (type(localizedStrings) == 'table' and localizedStrings[key])
    or string.format('Missing localized string "%s" in namespace "%s".', key, namespace)
end
