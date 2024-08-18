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
--- Creates a new map object, optionally initialized with given key-value pairs.
--- 
--- @alias utilities.collections.map
--- | fun(initial_content: table|nil): map
-- 

--#endregion

--#region [type: utilities.collections.map.object]

--
--- Represents a map object, providing methods to manage key-value pairs.
--- 
--- @class utilities.collections.map.object
--- 
--- @field entries number The number of key-value pairs in the map.
--- @field content dictionary<string|table, unknown> The underlying storage for the key-value pairs.
--- 
--- @field get fun(self: map, key: string): unknown Retrieves the value associated with the given key.
--- @field set fun(self: map, key: string, value: unknown) Sets the value for the given key.
--- @field drop fun(self: map, key: string) Removes the key-value pair with the given key.
--- @field has fun(self: map, key: string): boolean Checks if the map contains the given key.
--- @field size fun(self: map): number Returns the number of key-value pairs in the map.
--

--#endregion
