---@meta

---
--- Manages configuration settings for a plugin, providing access to stored settings as
--- well as default values. This can be used to retrieve or update configuration options
--- related to a specific plugin.
---
---@class configHandler
---
---@field context?          plugin                          -- The plugin context for the handler.
---@field defaults?         storage.unit                    -- The default configuration settings.
---
---@field getSetting        configHandler.getSetting        -- Retrieves a stored setting by its identifier.
---@field getDefaultSetting configHandler.getDefaultSetting -- Retrieves the default value of a setting by its identifier.
---@field setSetting        configHandler.setSetting        -- Updates the value of a stored setting by its identifier.
---

---
--- Retrieves a stored setting based on its identifier.
---
---@alias configHandler.getSetting  fun(self: configHandler, identifier: string): unknown
---

---
--- Retrieves the default value for a given setting.
---
---@alias configHandler.getDefaultSetting  fun(self: configHandler, identifier: string): unknown
---

---
--- Updates or sets a value for a specified setting in the plugin's configuration.
---
---@alias configHandler.setSetting  fun(self: configHandler, identifier: string, value: unknown)
---
