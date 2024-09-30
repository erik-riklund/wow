---@type string, contextProvider
local addon, repository = ...

--[[~ Service: Storage Unit (Service) ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/30

  Registers the storage unit component as a service, allowing
  plugins to use it for managing custom storage units.

]]

backbone.provideService('storage-unit', repository.use 'storage-unit')
