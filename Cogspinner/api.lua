--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, context
local addon, framework = ...

-- #region: framework context imports
-- #endregion

---
--- ?
---
--- @type api
---
_G.cogspinner = createProtectedProxy({
  createPlugin = framework.import('plugins/create'),
  executeCallback = framework.import('dispatch/execute')
} --[[@as api]] )
