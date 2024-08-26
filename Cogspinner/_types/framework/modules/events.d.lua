--- @meta

--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--#region [type: event handler]

--
--- ?
---
--- @class module.events
--- 
--- @field listeners map
--- 
--- @field register fun(self: module.events, listener: events.register.listener)
--- @field unregister fun(self: module.events, listener: events.unregister.listener)
---
--- @field invoke fun(self: module.events, event: string, ...)
--- @field initialize fun(self: module.events, plugin: string)
--

--#endregion

--#region [type: event API]

--
--- ?
---
--- @class events.API
--- 
--- @field parent? plugin.API
--- 
--- @field activate fun(self: events.API, listener: events.register.listener)
--- @field deactivate fun(self: events.API, listener: events.unregister.listener)
--- @field initialize fun(self: events.API, callback: function)
--

--#endregion

--#region [type: listener registration options]

--
--- ?
---
--- @class events.register.listener
--- 
--- @field event string
--- @field callback fun(...)
--- @field identifier? string
--

--#endregion

--#region [type: listener removal options]

--
--- ?
---
--- @class events.unregister.listener
--- 
--- @field event string
--- @field owner plugin.API
--- @field identifier string
--

--#endregion
