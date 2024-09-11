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
-- #endregion

---
--- ?
---
--- @type table<string, events.event>
---
local events = {}

---
--- ?
---
--- @type events.handler
---
local handler = {
  --
  -- ?
  --
  invokeEvent = function(event, arguments) end,

  --
  -- ?
  --
  registerListener = function(event, listener, context) end,

  --
  -- ?
  --
  removeListener = function(event, identifier, context) end
}

-- #region << exports >>
framework.export('events/handler', handler)
-- #endregion
