---@type string, contextProvider
local addon, context = ...

--[[~ Module: Context Repository ~

  Author(s): Erik Riklund
  Version: 1.0.0 | Updated: 2024/09/26

  The Context Repository provides a centralized mechanism for storing and retrieving objects by
  their unique identifiers. This allows different components of the framework or plugins to share
  resources, such as APIs or data, without requiring direct references.

  Features:
  - `use`: Retrieves an object by its identifier from the repository.
  - `expose`: Registers a new object in the repository under a given identifier, ensuring uniqueness.

]]

---@type table<string, unknown>
local repository = {}

context.use = function(identifier)
  if repository[identifier] == nil then
    throw('Unable to find object with identifier "%s".', identifier)
  end

  return repository[identifier]
end

context.expose = function(identifier, object)
  if repository[identifier] ~= nil then
    throw('Object with identifier "%s" already exists.', identifier)
  end

  repository[identifier] = object
end
