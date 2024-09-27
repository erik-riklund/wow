---@meta

---
--- ?
---
---@class configHandler
---
---@field context?  plugin "?"
---@field defaults? storage.unit "?"
---
---@field getSetting        configHandler.getSetting
---@field getDefaultSetting configHandler.getDefaultSetting
---@field setSetting        configHandler.setSetting
---

---
--- ?
---
---@alias configHandler.getSetting
---| fun(self: configHandler, identifier: string): unknown
---

---
--- ?
---
---@alias configHandler.getDefaultSetting
---| fun(self: configHandler, identifier: string): unknown
---

---
--- ?
---
---@alias configHandler.setSetting
---| fun(self: configHandler, identifier: string, value: unknown)
---
