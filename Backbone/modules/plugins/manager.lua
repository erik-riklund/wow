---@type string, contextProvider
local addon, repository = ...
local api = repository.use 'api' --[[@as api]]
local plugin = repository.use 'plugin-api' --[[@as plugin]]

--[[~ Module: Plugin Manager ~

  Version: 1.0.0 | Updated: 2024/09/25

  The plugin manager is responsible for managing plugins within the system. Plugins
  are identified by unique strings and stored in a protected form to prevent external
  modification. It provides mechanisms to create, register, and retrieve plugins.

  Developer's notes:

  - The `createPlugin` function ensures that plugin identifiers are unique before 
    registering a new plugin.
  
  - The manager exposes a method for retrieving registered plugins by their identifier,
    allowing safe access to plugins without external modification.

]]

---@type table<string, plugin>
local plugins = {}

---
--- Creates a new plugin and registers it under a unique identifier. The plugin is
--- wrapped in a protected proxy to ensure it cannot be directly modified.
---
---@type api.createPlugin
local createPlugin = function(identifier)
  -- Ensure the plugin identifier is unique. Throw an error if it already exists.
  if plugins[identifier] ~= nil then
    throw('Plugin with identifier "%s" already exists.', identifier)
  end

  -- Create a new plugin, inheriting from the base plugin API, and store it in the plugins table.
  plugins[identifier] = inheritParent({ identifier = identifier }, plugin)

  -- Return a protected proxy to the registered plugin to prevent external modification.
  return getProtectedProxy(plugins[identifier]) --[[@as plugin]]
end

---
--- Exposes a method to retrieve a plugin by its identifier. Throws an error if
--- the plugin does not exist.
---
repository.expose(
  'get-plugin',
  ---@param identifier string
  function(identifier)
    -- Check if the plugin exists, throw an error if it does not.
    if plugins[identifier] == nil then
      throw('Plugin with identifier "%s" not found.', identifier)
    end
    return plugins[identifier]
  end
)

---
--- Registers the `createPlugin` function within the API, allowing plugins to be
--- created using the framework's public API.
---
api.createPlugin = createPlugin
