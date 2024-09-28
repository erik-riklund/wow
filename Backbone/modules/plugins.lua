---@type string, contextProvider
local addon, repository = ...

local api = repository.use 'api' --[[@as api]]
local plugin = repository.use 'plugin-api' --[[@as plugin]]

--[[~ Module: Plugin Manager ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/27

  This module manages the registration and retrieval of plugins. It ensures that plugins are 
  uniquely identified and provides a way to create new plugins and access existing ones.

  Features:
  - Create and register plugins with unique identifiers.
  - Access plugins by their unique identifiers.
  
]]

---@type table<string, plugin>
local plugins = {}

--- This function creates a new plugin with the specified identifier. The identifier is normalized 
--- to ensure case-insensitivity. If the identifier is already in use or if it matches the reserved 
--- 'backbone' identifier, an error is thrown. The new plugin is then registered and returned as a 
--- protected proxy to ensure its integrity.

---@type api.createPlugin
api.createPlugin = function(identifier)
  local normalizedIdentifier = string.lower(identifier)

  if normalizedIdentifier == 'backbone' or plugins[normalizedIdentifier] ~= nil then
    throw('Plugin with identifier "%s" already exists.', identifier)
  end

  plugins[normalizedIdentifier] = inheritParent({ identifier = identifier }, plugin)
  return getProtectedProxy(plugins[normalizedIdentifier]) --[[@as plugin]]
end

--- This function exposes a method to retrieve an existing plugin by its identifier. The identifier 
--- is normalized to ensure case-insensitive access. If no plugin is found with the given identifier, 
--- an error is thrown. The function returns the plugin if it exists.

repository.expose('get-plugin', function(identifier)
  local normalizedIdentifier = string.lower(identifier)

  if plugins[normalizedIdentifier] == nil then
    throw('Plugin with identifier "%s" not found.', identifier)
  end

  return plugins[normalizedIdentifier]
end)
