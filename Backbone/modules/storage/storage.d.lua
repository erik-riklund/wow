---@meta

---@alias StorageScope 'account'|'character'

---
--- Retrieves a storage unit for a given plugin and specified scope.
---
---@alias StorageUnit.getStorageUnit fun(plugin: Plugin, scope: StorageScope): StorageUnit

---
--- Initializes a storage unit for a plugin with a specified scope and source data.
---
---@alias StorageUnit.setupStorageUnit fun(plugin: Plugin, scope: StorageScope, variable: string)

---
--- Defines options for initializing storage units, with account and character variable identifiers.
---
---@class StorageOptions
---@field storage? { account?: string, character?: string }

---
--- Represents a collection of storage units for a plugin.
---
---@class StorageUnits
---@field account? StorageUnit
---@field character? StorageUnit
