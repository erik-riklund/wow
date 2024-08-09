--- @meta

--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--#region (type: array)

--
--- A sequentially indexed table where each element's
--- position is determined by a numeric key.
--- 
--- @class array<value>: { [number]: value }
--

--#endregion

--#region (type: record)

--
--- An associative table where elements are stored
--- as key-value pairs, allowing retrieval by key.
--- 
--- @class record<key, value>: { [key]: value }
--

--#endregion

--#region (type: map)

--
--- ?
--- 
--- @class map
--- 
--- @field data record<unknown, unknown>
--- 
--- @field get fun(self: map, key: unknown): unknown
--- @field set fun(self: map, key: unknown, value: unknown)
--- @field has fun(self: map, key: unknown): boolean
--- @field contains fun(self: map, search_value: unknown): unknown | nil
--- @field values fun(self: map): record<unknown, unknown>
--- @field size fun(self: map): number
--

--#endregion

--#region (type: map.options)

--
--- ?
---
--- @class map.options
--- 
--- @field weak boolean
--

--#endregion

--#region (type: list)

--
--- ?
--- 
--- @class list
--- 
--- @field data array<unknown>
--- 
--- @field get fun(self: list, index: number): unknown | nil
--- @field contains fun(self: list, value: unknown): boolean
--- @field indexof fun(self: list, value: unknown): number
--- @field insert fun(self: list, value: unknown, position: number?)
--- @field remove fun(self: list, position: number?): unknown | nil
--- @field values fun(self: list): array<unknown>
--- @field length fun(self: list): number
--

--#endregion
