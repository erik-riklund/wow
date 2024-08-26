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
--

--#endregion

--#region [type: event API]

--
--- ?
---
--- @class events.API
--

--#endregion

--#region [type: listener registration options]

--
--- ?
---
--- @class events.listener.register_options
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
--- @class events.listener.unregister_options
--- 
--- @field event string
--- @field owner plugin.API
--- @field identifier string
--

--#endregion
