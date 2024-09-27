---@type string, contextProvider
local addon, repository = ...
local api = repository.use 'api' --[[@as api]]

--[[~ Module: Service Manager ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/27

  This module manages services within the framework. It provides a way for other components
  to register and retrieve services (functions or tables) by a unique identifier.

  Features:

  - Register a service with a unique identifier.
  - Retrieve a registered service by its identifier.
  - Ensure services cannot be re-registered with the same identifier.

]]

---@type table<string, function|table>
local services = {}

-- methods for the public API:

api.useService = function(identifier)
  if services[identifier] == nil then
    throw('Service "%s" is not registered.', identifier)
  end

  return services[identifier]
end

api.provideService = function(identifier, object)
  xtype.validate {
    { 'identifier:string', identifier },
    { 'object:function/table', object },
  }

  if services[identifier] ~= nil then
    throw('Service "%s" is already registered.', identifier)
  end

  services[identifier] = object
end
