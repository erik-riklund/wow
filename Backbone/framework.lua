---@type string, contextProvider
local addon, framework = ...

--[[~ Project: Backbone (framework) ~

  Author(s): Erik Riklund  
  Version: 1.0.0 | Updated: 2024/09/24
  
  This script initializes the core components of the Backbone framework. It sets up
  essential elements like the main API, plugin API, and a frame for handling events.
  Additionally, the framework's behavior can be controlled by toggling the `production` 
  flag, allowing for different modes (production vs. development).

  Design choices:
  - The production flag is exposed to control the framework's behavior, enabling or 
    disabling certain features depending on the environment.
  - Core components are exposed early to ensure they are available for use by other 
    modules or plugins throughout the framework.

]]

--
-- This flag can be toggled to enable or disable production-specific behaviors in
-- the framework, allowing different behavior in production vs. development modes.

framework.expose('production', false)

-- 
-- Expose the main API object to the framework. This API will be used by other 
-- components or plugins within the framework to register or access functionality.

framework.expose('api', {})

-- 
-- Expose the plugin API, which allows plugins to interact with the framework 
-- and access necessary resources or register themselves within the system.

framework.expose('plugin-api', {})

-- 
-- Expose a frame object for handling game-related events.

framework.expose('frame', CreateFrame 'Frame')

-- 
-- Retrieve a protected version of the API from the framework's context and assign 
-- it to the global `backbone` object, making it available throughout the ecosystem 
-- without allowing direct modifications.

_G.backbone = getProtectedProxy(framework.use 'api') --[[@as api]]
