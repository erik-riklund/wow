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
--- @class PluginManager
--- 
--- @field plugins Map
--- 
--- @field createPlugin fun(self: PluginManager, options: PluginManager.CreationOptions): Plugin
--- @field normalizeIdentifier fun(identifier: string): string
--

--#endregion

--#region [type: plugin creation options]

--
--- ?
---
--- @class PluginManager.CreationOptions
--- 
--- @field identifier string
--- @field channels? { name: string, internal?: boolean }[]
--

--#endregion

--#region [type: ]

--
--- @class PluginManager.CreationBroadcastPayload
--- 
--- @field plugin PartialPlugin
--- @field options PluginManager.CreationOptions
--

--#endregion