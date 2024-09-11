--- @meta
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--

---
--- @class events.handler
--- 
--- @field invokeEvent fun(event: string, arguments?: unknown[])
--- @field registerListener fun(event: string, listener: listener, context?: plugin)
--- @field removeListener fun(event: string, identifier: string, context?: plugin)
---

---
--- Represents a single event and its listeners.
--- 
--- @class events.event : listenerManager
---

---
--- @class events.api
--- 
--- @field onInitialize fun(self: plugin, callback: function)
--- @field registerEventListener fun(self: plugin, event: string, listener: listener)
--- @field removeEventListener fun(self: plugin, event: string, identifier: string)
---
