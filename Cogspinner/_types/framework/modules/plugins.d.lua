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
--- @field plugins list
--- @field create_context fun(self: module.plugin, id: string, options: plugin.options|nil): plugin.context
--

--#endregion

--#region [type: plugin context]

--
--- ?
---
--- @class plugin.context
--- 
--- @field id string
--

--#endregion

--#region [type: plugin creation options]

--
--- ?
--- 
--- @class plugin.options
--

--#endregion
