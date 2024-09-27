---@meta

---
--- Provides functionality for handling localized strings within plugins.
---
---@class locales.api
---
---@field getLocalizedString  locales.api.getLocalizedString
---@field registerLocale      locales.api.registerLocale
---

---
--- Retrieves a localized string for the given identifier within the plugin's context.
---
---@alias locales.api.getLocalizedString
---| fun(self: plugin, identifier: string): string
---

---
--- Registers a locale with its content, allowing the plugin to support multiple languages.
---
---@alias locales.api.registerLocale
---| fun(self: plugin, data: { locale: string, content: table<string, string>, fallback?: boolean })
---
