---@type string, contextProvider
local addon, repository = ...

local api = repository.use 'api' --[[@as api]]
local plugin = repository.use 'plugin-api' --[[@as plugin]]

--[[~ Module: Plugin Manager ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/27

  This module is responsible for registering and managing plugins
  within the framework. Each plugin is identified by a unique string
  and protected through a read-only proxy to ensure data integrity.

  Features:
  - Registers plugins with unique identifiers.
  - Protects registered plugins by returning them via a read-only proxy.
  - Provides a method to retrieve registered plugins.

]]

---@type table<string, plugin>
local plugins = {}

---@type api.createPlugin
api.createPlugin = function(identifier)
  if plugins[identifier] ~= nil then
    throw('Plugin with identifier "%s" already exists.', identifier)
  end

  plugins[identifier] = inheritParent({ identifier = identifier }, plugin)
  return getProtectedProxy(plugins[identifier]) --[[@as plugin]]
end

repository.expose('get-plugin', function(identifier)
  if plugins[identifier] == nil then
    throw('Plugin with identifier "%s" not found.', identifier)
  end

  return plugins[identifier]
end)
