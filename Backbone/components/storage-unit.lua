--[[~ Component: Storage Unit ~
  Updated: 2024/10/23 | Author(s): Erik Riklund (Gopher)
]]

local traverseTable = backbone.utilities.traverseTable

---@type StorageUnit
---@diagnostic disable-next-line: missing-fields
local storageUnit = {}

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
--- If the path points to a valid entry, it returns the corresponding value.

storageUnit.getEntry = function(self, path)
  local steps, variable = resolvePath(path)
  local source = traverseTable(self.data, steps)

  if type(source) == 'table' then return source[variable] end
end

---
--- Sets a value at the specified path in the storage unit,
--- creating any necessary intermediary tables along the way.

storageUnit.setEntry = function(self, path, value)
  local steps, variable = resolvePath(path)
  local target = traverseTable(self.data, steps, { mode = 'build' }) --[[@as table]]

  target[variable] = value
end

---
--- Removes the entry at the specified path from the storage unit,
--- setting it to nil if the path is valid.

storageUnit.dropEntry = function(self, path)
  local steps, variable = resolvePath(path)
  local source = traverseTable(self.data, steps)

  if type(source) == 'table' then source[variable] = nil end
end

---
--- Creates a new storage unit instance using the provided source as its data structure.
---
---@param source table
---
backbone.components.createStorageUnit = function(source)
  return backbone.utilities.inheritParent({ data = source }, storageUnit)
end
