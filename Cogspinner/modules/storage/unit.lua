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
--- @type storage.unit.constructor
---
local createStorageUnit = function()
  ---@diagnostic disable-next-line: missing-return
end

-- #region << exports >>
framework.export('storage/unit', createStorageUnit)
-- #endregion
