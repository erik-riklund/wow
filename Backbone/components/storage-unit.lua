---@type string, contextProvider
local addon, repository = ...

--[[~ Component: Storage Unit ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/27

  This component provides functionality to manage a hierarchical storage structure.
  It allows accessing and modifying table entries using a slash-delimited path, where
  the path represents the nested levels in the storage.

  Features:

  - Access and modify storage entries using a hierarchical path.
  - Automatically build table structure when modifying entries.
  
]]

---
--- resolvePath()
---
--- This function takes a slash-delimited path and splits it into table steps and a final variable.
--- It allows navigating through a table's structure by identifying each level of nesting based on
--- the path provided. The function returns the intermediate steps and the final variable to be
--- accessed or modified.
---
---@param path string "A slash-delimited string representing the path in a table."
---@return string[], string "A table of steps and the final variable to access."
---
local resolvePath = function(path)
  -- Split the path into steps by using '/' as the delimiter. If only one step is found,
  -- the function immediately returns the final variable without any intermediate steps.

  local steps = { string.split('/', path) }
  if #steps == 1 then
    return {}, steps[1] -- exit.
  end

  -- Remove the final part of the path, which represents the variable to be accessed or modified.
  -- The remaining steps represent the intermediate levels in the table structure.

  local variable = table.remove(steps) --[[@as string]]
  return steps, variable
end

---@type storage.unit
local unit = {
  --
  -- getEntry()
  --
  -- This function retrieves an entry from the storage unit based on the given path. It first resolves
  -- the path into steps and a final variable using `resolvePath`. Then, it navigates through the table
  -- structure to locate the desired entry. If the path leads to a valid entry, it is returned. If the
  -- entry is not found, the function returns `nil`.
  --

  getEntry = function(self, path)
    xtype.validate { { 'path:string', path } }

    local ancestors, variable = resolvePath(path)
    local target = traverseTable(self.data, ancestors)

    return (type(target) == 'table' and target[variable]) or nil
  end,

  --
  -- setEntry()
  --
  -- This function sets a value in the storage unit based on the provided path. It first resolves
  -- the path into intermediate steps and a final variable using `resolvePath`. If the path does not
  -- already exist in the table, the necessary structure is automatically built. The value is then
  -- assigned to the final variable in the table.
  --

  setEntry = function(self, path, value)
    xtype.validate { { 'path:string', path } }

    local ancestors, variable = resolvePath(path)
    local target = traverseTable(self.data, ancestors, { mode = 'build' })

    target[variable] = value
  end,
}

--
-- constructor()
--
-- This function creates a new instance of a storage unit. The provided table variable is used as the
-- data source, and the storage unit is equipped with the ability to retrieve and set entries based
-- on hierarchical paths. The resulting object can be used to manage storage efficiently.
--

---@type storage.unitConstructor
local constructor = function(variable)
  return inheritParent({ data = variable }, unit)
end

-- Expose the storage unit constructor through the repository,
-- making it available for use by other components or modules.

repository.expose('storage-unit', constructor)
