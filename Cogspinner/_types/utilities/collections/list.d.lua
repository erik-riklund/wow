--- @meta
--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--#region [alias: list]

--
--- @alias List ListObject
--

--#endregion

--#region [type: list constructor]

--
--- Creates a new list object, optionally initialized with values and weak table behavior.
--- 
--- @alias ListConstructor fun(initial_values: unknown[]|nil, options: { weak: WeakTableOptions }|nil): List
--

--#endregion

--#region [type: list object]

--
--- @class ListObject
--- 
--- @field values unknown[] The internal array storing the list's elements.
--- 
--- @field Get fun(self: List, index: number): unknown Retrieves an element by its index.
--- @field Replace fun(self: List, index: number, value: unknown) Replaces the value at the specified index.
--- @field Insert fun(self: List, value: unknown, position: number|nil) Inserts a value at a specific position (or at the end if no position is specified).
--- @field Remove fun(self: List, index: number|nil): unknown Removes and returns an element by index (or the last element if no index is specified).
--- 
--- @field Find fun(self: List, search_value: unknown): number Returns the index of a given value, or `-1` if not found.
--- @field Contains fun(self: List, search_value: unknown): boolean Checks if the list contains the given value.
--- @field Length fun(self: List): number Returns the number of elements in the list.
--

--#endregion
