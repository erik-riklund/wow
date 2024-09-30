---@type string, contextProvider
local addon, repository = ...

--[[~ Component: Storage Unit ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/30

  Provides functionality to resolve and access entries in a hierarchical table 
  structure using a path-like string. Supports retrieving and setting values at 
  specific paths in a data table.

  Features:

  - Resolves paths into table access.
  - Supports retrieval and modification of data at specific paths.
  
]]

---
--- Splits a slash-delimited path string into a series of table access steps,
--- and returns both the table of steps and the final variable to be accessed.
---
---@param path string "A slash-delimited string representing the path in a table."
---@return string[], string "A table of steps and the final variable to access."
---
local resolvePath = function(path)
  -- Splits the path into steps. If there is only one step,
  -- it is the variable, and no table traversal is required.

  local steps = { string.split('/', path) }
  if #steps == 1 then
    return {}, steps[1] -- exit.
  end

  -- Extracts the last part of the path as the final variable to be accessed.

  local variable = table.remove(steps) --[[@as string]]
  return steps, variable
end

---@type storage.unit
local unit = {
  -- Retrieves the value stored at the specified path in the data table,
  -- or returns `nil` if the entry does not exist.

  getEntry = function(self, path)
    xtype.validate { { 'path:string', path } }

    local ancestors, variable = resolvePath(path)
    local target = traverseTable(self.data, ancestors)

    return (type(target) == 'table' and target[variable]) or nil
  end,

  -- Sets the value at the specified path in the data table,
  -- creating intermediary tables if needed to build the path.

  setEntry = function(self, path, value)
    xtype.validate { { 'path:string', path } }

    local ancestors, variable = resolvePath(path)
    local target = traverseTable(self.data, ancestors, { mode = 'build' })

    target[variable] = value
  end,
}

-- Constructs a new storage unit instance with the provided initial
-- data table and exposes it as a storage unit component.

---@type storage.unitConstructor
local constructor = function(variable) return inheritParent({ data = variable }, unit) end

-- Exposes the component through the repository, making it available
-- for use by other components or modules.

repository.expose('storage-unit', constructor)
