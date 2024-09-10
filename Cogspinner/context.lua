--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, context
local addon, framework = ...

---
--- A central repository for objects exported by modules within the framework. It's
--- organized by object IDs to provide a global namespace and avoid naming conflicts.
---
framework.objects = {}

---
--- Exports (registers) an object to the central repository, making it available for import
--- by other modules. This function ensures unique identifiers to prevent conflicts and maintain
--- data integrity within the framework.
---
framework.export = function(identifier, object)
  if framework.objects[identifier] ~= nil then
    throw('Export failed, object "%s" already exists', identifier)
  end

  framework.objects[identifier] = object
end

---
--- Imports (retrieves) a previously exported object from the central repository using
--- its unique identifier. This function facilitates modularization by allowing modules
--- to access shared objects in a controlled manner.
---
framework.import = function(identifier)
  if framework.objects[identifier] == nil then
    throw('Import failed, unknown object "%s"', identifier)
  end

  return framework.objects[identifier]
end
