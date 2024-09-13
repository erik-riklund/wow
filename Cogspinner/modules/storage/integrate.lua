--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, framework.context
local addon, framework = ...

-- #region << imports >>
--- @type network.controller
local network = framework.import('network/controller')
--- @type storage.manager
local storage = framework.import('storage/manager')
-- #endregion

--
-- ?
--
network.registerListener('PLUGIN_ADDED', {
  --- @param plugin plugin
  --- @param options plugins.createPlugin.options
  callback = function(plugin, options)
    
  end
})
