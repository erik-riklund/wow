--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, framework.context
local addon, framework = ...

---
--- Facilitates navigation within nested data structures by parsing a path string
--- into its constituent parts: parent steps and final variable name.
--- 
--- @param path string
--- @return string[]?, string
---
local resolveVariablePath = function(path)
  local steps = splitString(path, '/')
  local variable = (#steps > 1 and table.remove(steps, #steps)) or path

  return ((variable ~= path and steps) or nil), variable --[[@as string]]
end

---
--- The prototype object for a storage unit provides methods for retrieving
--- and setting variables within its associated data structure.
--- 
--- @type storage.unit
---
local unit = {
  --
  -- Retrieves a variable's value from the storage unit,
  -- potentially navigating a nested path to find it.
  --
  getVariable = function(self, path)
    local parents, variable = resolveVariablePath(path)
    local target = (parents and traverseTable(self.data, parents)) or self.data

    return (type(target) == 'table' and target[variable]) or nil
  end,

  --
  -- Sets the value of a variable within the storage unit's data,
  -- creating any necessary intermediate tables along the path.
  --
  setVariable = function(self, path, value)
    local parents, variable = resolveVariablePath(path)
    local target = (parents and traverseTable(self.data, parents, 'build')) or self.data

    target[variable] = value -- `target` will never be "nil" here.
  end
}

---
--- Constructor function for creating storage units, linking them to the specified
--- global variable, and providing methods for variable access and modification.
--- 
--- @type storage.unit.constructor
---
local createStorageUnit = function(variable)
  _G[variable] = _G[variable] or {}

  return { data = _G[variable], getVariable = unit.getVariable, setVariable = unit.setVariable } --[[@as storage.unit]]
end

-- #region << exports >>
framework.export('storage/unit', createStorageUnit)
-- #endregion
