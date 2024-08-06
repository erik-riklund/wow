--- @meta

--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--#region (type: map)

--- An associative table where elements are stored as key-value pairs, allowing retrieval by key.
--- @class map<key, value>: { [key]: value }

--#endregion

--#region (type: list)

--- A sequentially indexed table where each element's position is determined by a numeric key.
--- @class list<value>: { [number]: value }

--#endregion

--#region (type: map.instance)

--- ?
--- @class map.instance
--- @field data map<unknown, unknown>
--- @field get fun(self: map.instance, key: unknown): unknown
--- @field set fun(self: map.instance, key: unknown, value: unknown)
--- @field has fun(self: map.instance, key: unknown): boolean
--- @field contains fun(self: map.instance, search_value: unknown): unknown|nil
--- @field size fun(self: map.instance): number
--- @field values fun(self: map.instance): unknown

--#endregion

--#region (type: list.instance)

--- ?
--- @class list.instance
--- @field data map<number, unknown>
--- @field get fun(self: list.instance, index: number): unknown | nil
--- @field contains fun(self: list.instance, value: unknown): boolean
--- @field indexof fun(self: list.instance, value: unknown): number
--- @field insert fun(self: list.instance, value: unknown, position: number?)
--- @field remove fun(self: list.instance, position: number?): unknown | nil
--- @field length fun(self: list.instance): number
--- @field values fun(self: list.instance): unknown

--#endregion
