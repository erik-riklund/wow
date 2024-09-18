--
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, framework
local addon, framework = ...

--- @type library.resolveVariablePath
local resolveVariablePath = framework.import('library/resolve-path')

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
    
    if type(target) == 'table' and target[variable] ~= nil then return target[variable] end

    return nil
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

  return {
    data = _G[variable],
    getVariable = unit.getVariable,
    setVariable = unit.setVariable
  } --[[@as storage.unit]]
end

--
framework.export('storage/unit', createStorageUnit)
