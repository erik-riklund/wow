---@meta

---
--- Represents a storage unit that manages a collection of data, allowing for 
--- retrieval, modification, and deletion of entries based on a specified path.
---
---@class StorageUnit
---@field data table
---
---@field getEntry StorageUnit.getEntry
---@field setEntry StorageUnit.setEntry
---@field dropEntry StorageUnit.dropEntry

---
--- Retrieves the value stored at the specified path in the storage unit.
---
---@alias StorageUnit.getEntry fun(self: StorageUnit, path: string): unknown?

---
--- Sets a value at the specified path in the storage unit,
--- creating any necessary intermediary tables along the way.
---
---@alias StorageUnit.setEntry fun(self: StorageUnit, path: string, value: unknown)

---
--- Removes the entry at the specified path from the storage unit.
---
---@alias StorageUnit.dropEntry fun(self: StorageUnit, path: string)
