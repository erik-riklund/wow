---@meta

---@alias StorageScope 'account'|'character'

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
