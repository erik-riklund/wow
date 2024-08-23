--- @meta

--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            

--#region [type: event controller]

--
--- ?
--- 
--- @class module.events
--- 
--- @field listeners map
-- 

--#endregion

--#region [type: listener registration arguments]

--
--- ?
---
--- @class events.listen.arguments
--- 
--- @field event string
--- @field callback function
--- 
--- @field callback_id? string
--

--#endregion

--#region [type: plugin-context event API]

--
--- ?
---
--- @class events.API
--- 
--- @field parent? plugin.API
--- 
--- @field listen fun(self: events.API, options: events.listen.arguments)
--- @field silence fun(self: events.API, event: string, callback_id: string|nil)
--

--#endregion
