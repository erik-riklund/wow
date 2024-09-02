--- @meta
--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--
--- @alias Map MapObject
--

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

--
--- ?
---
--- @alias MapKey string|table
--

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

--
--- Creates a new map object, optionally initialized with given key-value pairs.
---
--- @alias MapConstructor fun(initial_content: table|nil, options: { weak: WeakTableOptions }|nil): Map
--

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

--
--- @class MapObject
---
--- @field entries number The number of key-value pairs in the map.
--- @field content Record<MapKey, unknown> The underlying storage for the key-value pairs.
---
--- @field get fun(self: Map, key: MapKey): unknown Retrieves the value associated with the given key.
--- @field set fun(self: Map, key: MapKey, value: unknown) Sets the value for the given key.
--- @field drop fun(self: Map, key: MapKey) Removes the key-value pair with the given key.
--- @field has fun(self: Map, key: MapKey): boolean Checks if the map contains the given key.
--- @field size fun(self: Map): number Returns the number of key-value pairs in the map.
--
