local ADDON, CORE = ...

--
--      #
--     # #   #    #  ####  #    # ###### #    # #####
--    #   #  #    # #    # ##  ## #      ##   #   #
--   #     # #    # #      # ## # #####  # #  #   #
--   ####### #    # #  ### #    # #      #  # #   #
--   #     # #    # #    # #    # #      #   ##   #
--   #     #  ####   ####  #    # ###### #    #   #
--
-- World of Warcraft addon ecosystem, created by Erik Riklund (2024)
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

local ServiceHandler = CORE.ServiceHandler
local Services = ServiceHandler.Services

--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--- Registers a new service in the service registry.
--
-- @param id string The unique ID to associate with the service.
-- @param service any The service object or instance to register.
-- @throws error If a service with the specified ID already exists. The error message 
--               includes the conflicting service ID.
--

function ServiceHandler:AddService(id, service)
  --
  if Services[id] then
    Throw("There is already a registered service named '$service'",{service = id})
  end

  Services[id] = service
end

--
--- Retrieves a registered service by its ID.
--
-- @param id string The ID of the service to retrieve.
-- @return any The requested service object or instance.
-- @throws error If no service is found with the provided ID. The error message includes
--               the missing service ID.
--

function ServiceHandler:GetService(id)
  --
  if not Services[id] then
    Throw("There is no service named '$service' available",{service = id})
  end

  return Services[id]
end
