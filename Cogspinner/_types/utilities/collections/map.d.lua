--- @meta
--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--#region [alias: map object]

--
--- @alias Map MapObject
--

--#endregion

--#region [alias: map key]

--
--- ?
---
--- @alias MapKey string|table
--

--#endregion

--#region [type: map constructor]

--
--- Creates a new map object, optionally initialized with given key-value pairs.
---
--- @alias MapConstructor fun(initial_content: table|nil, options: { weak: WeakTableOptions }|nil): Map
--

--#endregion

--#region [type: utilities.collections.map.object]

--
--- Represents a map object, providing methods to manage key-value pairs.
---
--- @class MapObject
---
--- @field entries number The number of key-value pairs in the map.
--- @field content Record<MapKey, unknown> The underlying storage for the key-value pairs.
---
--- @field Get fun(self: Map, key: MapKey): unknown Retrieves the value associated with the given key.
--- @field Set fun(self: Map, key: MapKey, value: unknown) Sets the value for the given key.
--- @field Drop fun(self: Map, key: MapKey) Removes the key-value pair with the given key.
--- @field Has fun(self: Map, key: MapKey): boolean Checks if the map contains the given key.
--- @field Size fun(self: Map): number Returns the number of key-value pairs in the map.
--

--#endregion
