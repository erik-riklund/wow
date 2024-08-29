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
--- @field invoke fun(self: module.events, event: string, ...)
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
--- @field listen fun(self: events.API, listener: events.API.listen.listener)
--- @field silence fun(self: events.API, listener: events.API.silence.listener)
--

--#endregion

--#region [type: event listener]

--
--- ?
--- 
--- @class events.listener
--- 
--- @field owner plugin.API
--- @field callback function
--- @field recurring boolean
--- @field identifier? string
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
--- 
--- @field owner plugin.API
--- @field identifier? string
--- @field recurring? boolean
--

--#endregion

--#region [type: listener registration options (API)]

--
--- ?
---
--- @class events.API.listen.listener
--- 
--- @field event string
--- @field callback fun(...)
--- @field identifier? string
--- @field recurring? boolean
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

--#region [type: listener removal options (plugin API)]

--
--- ?
---
--- @class events.API.silence.listener
--- 
--- @field event string
--- @field identifier string
--

--#endregion
