--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, IContext
local addon, framework = ...

---
--- The collection of plugins that are registered or available within the framework.
---
--- @type table<string, Plugin>
---
local plugins = {}

---
--- Responsible for creating new plugin instances and registering them within the framework.
---
--- @type PluginCreator
---
local createPlugin = function(identifier)
  if plugins[identifier] ~= nil then
    throw('Failed to register plugin "%s" (non-unique identifier)')
  end

  plugins[identifier] = { identifier = identifier }
  -- todo: broadcast the new plugin context through the 'PLUGIN_ADDED' channel.

  return plugins[identifier]
end

--
-- Expose the function to the framework context.
--
framework.export('create-plugin', createPlugin)
