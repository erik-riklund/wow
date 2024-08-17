--- @meta

--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--#region [alias: map]

--
--- @alias map utilities.collections.map.object
--

--#endregion

--#region [type: utilities.collections.map]

--
--- ?
--- 
--- @alias utilities.collections.map
--- | fun(initial_content: table|nil): map
-- 

--#endregion

--#region [type: utilities.collections.map.object]

--
--- ?
--- 
--- @class utilities.collections.map.object
--- 
--- @field entries number
--- @field content dictionary<string|table, unknown>
--- 
--- @field get fun(self: map, key: string): unknown
--- @field set fun(self: map, key: string, value: unknown)
--- @field drop fun(self: map, key: string)
--- @field has fun(self: map, key: string): boolean
--- @field size fun(self: map): number
--

--#endregion
