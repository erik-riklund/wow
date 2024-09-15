--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, framework.context
local addon, framework = ...

-- #region << imports >>
--- @type storage.unit.constructor
local createStorageUnit = framework.import('storage/unit')
-- #endregion

---
--- Serves as a central hub for storing and managing storage units associated with plugins.
---
--- @type table<string, storage.unit>
---
local storage = {}

---
--- Generates a unique identifier for a storage unit, considering both the
--- plugin's identifier and the storage scope (account or character).
---
--- @param plugin plugin
--- @param scope  storage.scope
---
local createUnitIdentifier = function(plugin, scope)
  return string.format('%s:%s', plugin.identifier, scope)
end

---
--- The core manager handles storage units, retrieving existing ones and creating new ones as needed.
---
--- @type storage.manager
--- 
local manager = {
  --
  -- Retrieves a storage unit for the given context (plugin) and scope ('account' or 'character').
  --
  getStorageUnit = function(context, scope)
    local identifier = createUnitIdentifier(context, scope)

    if not storage[identifier] then
      throw('The storage unit "%s" has not been initialized', identifier)
    end

    return storage[identifier]
  end,

  --
  -- Sets up a new storage unit for the specified context (plugin), scope, and variable name.
  --
  setupStorageUnit = function(context, scope, variable)
    local identifier = createUnitIdentifier(context, scope)
    storage[identifier] = createStorageUnit(variable)
  end
}

-- #region << exports >>
framework.export('storage/manager', manager)
-- #endregion
