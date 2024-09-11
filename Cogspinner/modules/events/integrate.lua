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

--
-- ?
--
network.registerListener('PLUGIN_ADDED', {
  --- @param plugin plugin
  callback = function(plugin)
    -- todo: integration of the events API.
  end
})
