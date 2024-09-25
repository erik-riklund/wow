---@type string, contextProvider
local addon, repository = ...

--[[~ Project: Backbone (framework) ~

  Author(s): Erik Riklund  
  Version: 1.0.0 | Updated: 2024/09/24
  
  This script initializes the Backbone framework by exposing core components like 
  the main API, plugin API, and a frame for handling events. These components are 
  made accessible to other parts of the framework while being protected against 
  external modification.

  Developer's notes:

  - The main API and plugin API are exposed early in the process to ensure
    they are available to the entire framework.

  - A frame object is exposed for handling game-related events, which will 
    be central to the framework's event handling system.

  - The `backbone` global object is set up as a protected version of the API, 
    ensuring that it can be accessed but not modified externally.

]]

-- 
-- Expose the main API object to the framework. This API will be used by other 
-- components or plugins within the framework to register or access functionality.
--
repository.expose('api', {})

-- 
-- Expose the plugin API, which allows plugins to interact with the framework 
-- and access necessary resources or register themselves within the system.
--
repository.expose('plugin-api', {})

-- 
-- Expose a frame object for handling game-related events.
--
repository.expose('frame', CreateFrame 'Frame')

-- 
-- Retrieve a protected version of the API from the framework's context and assign 
-- it to the global `backbone` object, making it available throughout the ecosystem 
-- without allowing direct modifications.
--
_G.backbone = getProtectedProxy(repository.use 'api') --[[@as api]]
