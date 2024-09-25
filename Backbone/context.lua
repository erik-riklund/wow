---@type string, contextProvider
local addon, repository = ...

--[[~ Module: Context Repository ~

  Author(s): Erik Riklund
  Version: 1.0.0 | Updated: 2024/09/24

  This module provides a repository for managing and sharing objects between different
  parts of the system. Objects can be exposed under a unique identifier and accessed 
  later using that identifier, ensuring a controlled way of sharing resources.

  Design choices:
  - The repository ensures that each identifier is unique, preventing collisions.
  - The `use` function retrieves objects by identifier, while the `expose` function 
    allows new objects to be added.

]]

---@type table<string, unknown>
local repository = {}

--
-- Retrieves an object from the repository based on the provided identifier. If the
-- identifier does not exist, an error is thrown.
--
repository.use = function(identifier)
  if repository[identifier] == nil then
    throw('Unable to find object with identifier "%s".', identifier)
  end

  return repository[identifier]
end

--
-- Exposes a new object to the repository under the given identifier. If an object
-- with the same identifier already exists, an error is thrown to prevent overwriting.
--
repository.expose = function(identifier, object)
  if repository[identifier] ~= nil then
    throw('Object with identifier "%s" already exists.', identifier)
  end

  repository[identifier] = object
end
