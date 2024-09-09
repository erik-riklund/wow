--- @meta
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--

---
--- Invokes the given callback function, optionally with arguments,
--- either immediately or asynchronously (default behavior).
--- 
--- @alias callbacks.executeCallback
--- | fun(callback: function, arguments?: unknown[], options?: { async: boolean })
---

---
--- @alias callbacks.executeCallbackAsync fun(callback: function, arguments?: unknown[])
---

---
--- @class callbacks.backgroundTask
--- 
--- @field callback function
--- @field arguments unknown[]
---
