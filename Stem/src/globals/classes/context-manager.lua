--[[

  Project: Stem (framework)
  Module: Context Management
  Version: 1.0.0

  Author(s): Erik Riklund
  Created: 2024/09/19 | Updated: 2024/09/19

  Description:
  Provides a context manager that allows exposing and using objects via unique
  identifiers. The context ensures that only registered objects are used, and 
  prevents exposing objects with duplicate identifiers.

  Notes:

  - This module uses `exception.generic` to handle error reporting when using or 
    exposing objects with invalid or duplicate identifiers.

  Usage:

  - Use `_G.integrateContextProvider(object)` to integrate the context manager into an
    existing object, allowing it to expose and use objects via unique identifiers.

]]

---
--- A context manager that provides functionality for exposing objects under unique
--- identifiers and retrieving them later. It ensures no duplicate identifiers are
--- used, and throws an error when attempting to use an unregistered object.

---
--- @type context
---
local context = {
  --
  -- Retrieves an object from the context by its unique identifier. Throws an error
  -- if the object is not found, ensuring only registered objects can be used.

  use = function(self, identifier)
    if self.objects[identifier] == nil then
      exception.generic('Unable to use "%s" (unknown object).', identifier)
    end

    return self.objects[identifier]
  end,

  -- Exposes an object within the context under a unique identifier. Throws an error
  -- if the identifier is already in use, preventing duplicate entries in the context.

  expose = function(self, identifier, object)
    if self.objects[identifier] ~= nil then
      exception.generic('Unable to expose object "%s" (non-unique identifier).', identifier)
    end

    self.objects[identifier] = object
  end,
}

---
--- Integrates a context provider into the given `object`, allowing the object to
--- expose and use other objects through unique identifiers. It merges the context
--- manager's functionality into the provided object.
---
--- @param object table  "The object into which the context manager is integrated."
---
_G.integrateContextManager = function(object)
  return inheritFromParent(integrateTable(object, { objects = {} }), context)
end
