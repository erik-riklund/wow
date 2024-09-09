--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, core.context
local addon, framework = ...

--- @type network.invokeChannel
local invokeChannel = framework.import('channel/invoke')

---
--- The collection of plugins that are registered or available within the framework.
---
--- @type table<string, plugin>
---
local plugins = {}

---
--- Responsible for creating new plugin instances and registering them within the framework.
---
--- @type plugins.createPlugin
---
local createPlugin = function(identifier)
  if plugins[identifier] ~= nil then
    throw('Failed to register plugin "%s" (non-unique identifier)')
  end

  plugins[identifier] = { identifier = identifier }
  invokeChannel('PLUGIN_ADDED', { plugins[identifier] })

  return plugins[identifier]
end

--
-- Expose the function to the framework context.
--
framework.export('plugin/create', createPlugin)
