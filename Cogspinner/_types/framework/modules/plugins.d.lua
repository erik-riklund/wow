--- @meta
--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--#region [type: plugin API]

--
--- @class Plugin
--- 
--- @field id string
--- @field network NetworkControllerApi
--

--#endregion

--#region [type: partial plugin API]

--
--- @class PartialPlugin
--- 
--- @field id string
--- @field network? NetworkControllerApi
--

--#endregion

--#region [alias: plugin context]

---
--- @alias PluginContext Plugin|PartialPlugin
---

--#endregion
