---@type string, contextProvider
local addon, repository = ...

--[[~ Service: Storage Unit Service ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/28

  This service provides access to the storage unit component, allowing other components or 
  plugins to create and manage storage units for hierarchical data management.

  Features:

  - Provide a service for creating and managing storage units.
  - Expose the storage unit functionality to other components or plugins.
  
  Dependencies: Storage Unit (component)

]]

backbone.provideService('storage-unit', repository.use 'storage-unit')
