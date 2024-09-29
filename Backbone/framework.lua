---@type string, contextProvider
local addon, repository = ...

--[[~ Project: Backbone (framework) ~

  Author(s): Erik Riklund  
  Version: 1.0.0 | Updated: 2024/09/24
  
  The Backbone framework provides core functionality for managing plugin interaction and event
  handling. It serves as a foundational layer where plugins can be registered and interact with
  the underlying game API in a structured and controlled manner.

  Features:
  - Exposes a protected `api` object that can be accessed globally but cannot be modified directly.
  - Provides an isolated `plugin-api` for managing plugin interactions with the framework.
  - Offers a `frame` object to handle game-related events.

]]

-- Exposing the main API and plugin API to the framework. These objects are used by
-- other components or plugins to access or register functionality in the system.

repository.expose('api', {})
repository.expose('plugin-api', {})

-- Create and expose a frame object to handle game events.

repository.expose('frame', CreateFrame 'Frame')

-- Make the protected API accessible globally, while preventing direct
-- modifications to it by using a protected proxy.

_G.backbone = getProtectedProxy(repository.use 'api') --[[@as api]]
