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
-- #endregion

---
--- ?
---
--- @type table<string, table<'account'|'character', storage.unit>>
---
local storage = {}

---
--- ?
---
--- @type storage.manager
--- 
local manager = {}

-- #region << exports >>
framework.export('storage/manager', manager)
-- #endregion
