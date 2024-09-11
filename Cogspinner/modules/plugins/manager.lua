--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, context
local addon, framework = ...

-- #region << imports >>
--- @type network.controller
local network = framework.import('network/controller')
-- #endregion

---
--- ?
---
--- @type table<string, plugin>
---
local plugins = {}

---
--- ?
---
--- @type plugins.createPlugin
---
local createPlugin = function(identifier, options)
  if plugins[identifier] ~= nil then
    throw('Unable to create plugin "%s" (non-unique identifier)', identifier)
  end

  plugins[identifier] = { identifier = identifier }
  network.invokeChannel('PLUGIN_ADDED', { plugins[identifier], options })

  return createProtectedProxy(plugins[identifier])
end

-- #region << exports >>
framework.export('plugins/create', createPlugin)
-- #endregion
