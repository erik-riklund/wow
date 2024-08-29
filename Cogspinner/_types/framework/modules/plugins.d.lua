--- @meta

--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--#region [type: plugin manager]

--
--- Manages the creation, registration, and lifecycle of plugins within the framework.
---
--- @class module.plugins
---
--- @field plugins map
---
--- @field create_plugin fun(self: module.plugins, id: string, options: plugin.options|nil): plugin.API
--- @field broadcast_new_plugin fun(plugin: plugin.base_context, options: plugin.options|nil)
--- @field normalize_id fun(id: string): string
--

--#endregion

--#region [type: plugin options]

--
--- ?
---
--- @class plugin.options
--

--#endregion

--#region [type: base context]

--
--- ?
---
--- @class plugin.base_context
--- 
--- @field id string
--- @field event? events.API
--- 
--- @field initialize? plugin.initialize
--

--#endregion

--#region [type: plugin API]

--
--- ?
---
--- @class plugin.API
--- 
--- @field id string
--- @field event events.API
--- 
--- @field initialize plugin.initialize
--

--#endregion

--#region [type: plugin initializer]

--
--- ?
--- 
--- @alias plugin.initialize fun(self: plugin.API, callback: function)
--

--#endregion

--#region [type: broadcast payload]

--
--- ?
---
--- @class plugin.added.payload
--- 
--- @field plugin plugin.base_context
--- @field options? plugin.options
--

--#endregion
