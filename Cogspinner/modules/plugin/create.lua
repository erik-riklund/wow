--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, core.context
local addon, framework = ...

--- @type table.createProtectedProxy
local createProtectedProxy = framework.import('table/protect')

--- @type network.invokeChannel
local invokeChannel = framework.import('channel/invoke')

---
--- The collection of plugins that are registered within the framework.
---
--- @type table<string, plugin>
---
local plugins = {}

---
--- Creates and registers new plugin instances, returning their contexts
--- wrapped in immutable proxies to prevent accidental modifications.
---
--- @type plugins.createPlugin
---
local createPlugin = function(identifier, options)
  if plugins[identifier] ~= nil then
    throw('Failed to register plugin "%s" (non-unique identifier)')
  end

  plugins[identifier] = { identifier = identifier }
  invokeChannel('PLUGIN_ADDED', { plugins[identifier], options })

  return createProtectedProxy(plugins[identifier])
end

---
--- Retrieves the context object of a specific plugin using its unique identifier.
---
--- @type plugins.retrievePluginContext
---
local retrievePluginContext = function(identifier)
  if plugins[identifier] == nil then
    throw('Failed to retrieve unknown plugin "%s"', identifier)
  end

  return plugins[identifier]
end

--
-- Expose the function to the framework context.
--
framework.export('plugin/create', createPlugin)
framework.export('plugin/retrieve', retrievePluginContext)
