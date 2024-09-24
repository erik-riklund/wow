---@meta

---
--- ?
---
---@class storage.api
---
---@field getAccountVariable    storage.api.getAccountVariable
---@field setAccountVariable    storage.api.setAccountVariable
---@field getCharacterVariable  storage.api.getCharacterVariable
---@field setCharacterVariable  storage.api.setCharacterVariable
---

---
--- ?
---
---@alias storage.api.getAccountVariable
---| fun(self: plugin, identifier: string): unknown
---

---
--- ?
---
---@alias storage.api.setAccountVariable
---| fun(self: plugin, identifier: string, value: unknown)
---

---
--- ?
---
---@alias storage.api.getCharacterVariable
---| fun(self: plugin, identifier: string): unknown
---

---
--- ?
---
---@alias storage.api.setCharacterVariable
---| fun(self: plugin, identifier: string, value: unknown)
---
