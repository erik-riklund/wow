--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, context
local addon, framework = ...

---
--- Provides essential methods for interacting with the framework.
---
--- @type api
---
local api = {
  createPlugin = framework.import('plugins/create'),
  executeCallback = framework.import('dispatch/execute')
}

---
--- The framework's API, providing access to key modules and services.
---
_G.cogspinner = createProtectedProxy(api) --[[@as api]]
