--- @meta

--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|


--#region [type: plugin manager]

--
--- ?
---
--- @class module.plugin
---
--- @field plugins map
--- 
--- @field create_plugin fun(self: module.plugin, id: string, options: plugin.options|nil): plugin.API
--

--#endregion

--#region [type: plugin API]

--
--- ?
--- 
--- @class plugin.API
--- 
--- @field id string
--- @field events events.API
--- 
--- @field when_loaded fun(self: plugin.API, callback: function)
--

--#endregion

--#region [type: partial plugin API]

--
--- ?
---
--- @class plugin.context
--- 
--- @field id string
--- @field events? events.API
--- 
--- @field when_loaded fun(self: plugin.API, callback: function)
--

--#endregion

--#region [type: plugin creation options]

--
--- ?
--- 
--- @class plugin.options
--

--#endregion
