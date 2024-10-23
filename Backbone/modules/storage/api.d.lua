---@meta

---
--- Defines the API for managing storage variables for plugins.
---
---@class StorageApi
---@field getAccountVariable StorageApi.getAccountVariable
---@field getCharacterVariable StorageApi.getCharacterVariable
---@field setAccountVariable StorageApi.setAccountVariable
---@field setCharacterVariable StorageApi.setCharacterVariable

---
--- Retrieves the value of an account variable based on the given path.
---
---@alias StorageApi.getAccountVariable fun(self: Plugin, path: string): unknown

---
--- Retrieves the value of a character variable based on the given path.
---
---@alias StorageApi.getCharacterVariable fun(self: Plugin, path: string): unknown

---
--- Sets the value of an account variable at the specified path.
---
---@alias StorageApi.setAccountVariable fun(self: Plugin, path: string, value: unknown)

---
--- Sets the value of a character variable at the specified path.
---
---@alias StorageApi.setCharacterVariable fun(self: Plugin, path: string, value: unknown)
