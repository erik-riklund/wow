---@type string, contextProvider
local addon, repository = ...

--[[~ Component: Storage Unit ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/27

  This module provides a storage unit that allows accessing and manipulating entries in a
  hierarchical table structure using path notation. It resolves paths into separate table steps,
  allowing dynamic and flexible table traversal.

  Features:

  - Resolves path notation into table access steps
  - Provides methods to get and set entries in a table
  
]]

---
--- Resolves a given string path into table steps and a final variable.
---
---@param path string "A slash-delimited string representing the path in a table."
---@return string[], string "A table of steps and the final variable to access."
---
local resolvePath = function(path)
  local steps = { string.split('/', path) }
  if #steps == 1 then
    return {}, steps[1] -- exit.
  end

  local variable = table.remove(steps) --[[@as string]]
  return steps, variable
end

---@type storage.unit
local unit = {
  getEntry = function(self, path)
    xtype.validate { { 'path:string', path } }

    local ancestors, variable = resolvePath(path)
    local target = traverseTable(self.data, ancestors)

    return (type(target) == 'table' and target[variable]) or nil
  end,

  setEntry = function(self, path, value)
    xtype.validate { { 'path:string', path } }

    local ancestors, variable = resolvePath(path)
    local target = traverseTable(self.data, ancestors, { mode = 'build' })

    target[variable] = value
  end,
}

---@type storage.unitConstructor
local constructor = function(variable)
  return inheritParent({ data = _G[variable] }, unit)
end

-- expose the constructor to the framework context:
repository.expose('storage-unit', constructor)
