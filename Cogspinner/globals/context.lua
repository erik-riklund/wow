--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--

---
--- Registers a new object, ensuring its uniqueness through its identifier.
---
--- @param self context
--- @param identifier string
--- @param object unknown
---
local export = function(self, identifier, object)
  if self.objects[identifier] ~= nil then
    throw('Export failed, object "%s" already exists', identifier)
  end

  self.objects[identifier] = object
end

---
--- Retrieves an exported object based on its identifier.
---
--- @param self context
--- @param identifier string
--- @return unknown
---
local import = function(self, identifier)
  if self.objects[identifier] == nil then
    throw('Import failed, unknown object "%s"', identifier)
  end

  return self.objects[identifier]
end

---
--- Integrates context handling capabilities into a given table, enabling
--- modularity by facilitating export and import of objects.
---
--- @param target table
---
_G.integrateContextHandler = function(target)
  if type(target) ~= 'table' then
    throw('Context handler integration failed, expected a table for "target"')
  end

  target.objects = {}
  target.export = export
  target.import = import

  return target --[[@as context]]
end
