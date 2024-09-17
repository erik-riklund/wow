--
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
--- Serves as a central hub for storing services within the framework.
---
--- @type table<string, unknown>
---
local services = {}

---
--- Retrieves a registered service from the repository using its unique identifier and,
--- if the service is a function, returns it directly; otherwise, creates a read-only proxy
--- to prevent modification of the service's internal state.
---
--- @type services.getService
---
local getService = function(identifier)
  if services[identifier] == nil then
    throw('Service retrieval failed, unknown service "%s"', identifier)
  end

  return (type(services[identifier]) == 'function' and services[identifier])
          or createProtectedProxy(services[identifier])
end

---
--- Registers a new service in the repository, associating it with a unique identifier,
--- while ensuring the identifier is unique and the service object is either a function or a table.
---
--- @type services.registerService
---
local registerService = function(identifier, object)
  if services[identifier] ~= nil then
    throw('Service registration failed, non-unique identifier "%s"', identifier)
  end

  if type(object) ~= 'function' and type(object) ~= 'table' then
    throwTypeError('object', 'function|table', type(object))
  end

  services[identifier] = object
end

--
framework.export('services/get', getService)
framework.export('services/register', registerService)
