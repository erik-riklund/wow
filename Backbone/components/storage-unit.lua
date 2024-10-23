local traverseTable = backbone.utilities.traverseTable

--[[~ Component: Storage Unit ~
  Updated: 2024/10/23 | Author(s): Erik Riklund (Gopher)
]]

---
--- Represents a storage unit that manages a collection of data, allowing for 
--- retrieval, modification, and deletion of entries based on a specified path.
---
---@class StorageUnit
---
local storageUnit = {}

---
--- The data structure used by the storage unit.
---
storageUnit.data = {}

---
--- Resolves a given path string into an array of steps and a final variable name.
---
---@param path string
---@return string[], string
---
local resolvePath = function(path)
  ---@type string[]
  local steps = { string.split('/', path) }
  local variable = table.remove(steps) --[[@as string]]

  return steps, variable
end

---
--- Retrieves the value stored at the specified path in the storage unit.
--- 
---@param path string
---@return unknown?
--- 
storageUnit.getEntry = function(self, path)
  local steps, variable = resolvePath(path)
  local source = traverseTable(self.data, steps)

  if type(source) == 'table' then return source[variable] end
end

---
--- Sets a value at the specified path in the storage unit,
--- creating any necessary intermediary tables along the way.
---
---@param path string
---@param value unknown
---
storageUnit.setEntry = function(self, path, value)
  local steps, variable = resolvePath(path)
  local target = traverseTable(self.data, steps, { mode = 'build' }) --[[@as table]]

  target[variable] = value
end

---
--- Removes the entry at the specified path from the storage unit.
---
---@param path string
---
storageUnit.dropEntry = function(self, path)
  local steps, variable = resolvePath(path)
  local source = traverseTable(self.data, steps)

  if type(source) == 'table' then source[variable] = nil end
end

---
--- Creates a new storage unit instance using the provided source as its data structure.
---
---@param source table
---@return StorageUnit
---
backbone.components.createStorageUnit = function(source)
  return backbone.utilities.inheritParent({ data = source }, storageUnit)
end
