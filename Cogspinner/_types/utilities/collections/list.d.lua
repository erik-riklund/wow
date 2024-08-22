--- @meta

--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--#region [alias: list]

--
--- @alias list utility.collection.list.object
--

--#endregion

--#region [type: utilities.collection.list]

--
--- Creates a new list object, optionally initialized with values and weak table behavior.
--- 
--- @alias utility.collection.list
--- | fun(initial_values: unknown[]|nil, options: { weak: table.weak_options }|nil): list
--

--#endregion

--#region [type: utilities.collection.list.object]

--
--- Represents a list object with associated methods for manipulating its contents.
--- 
--- @class utility.collection.list.object
--- 
--- @field values unknown[] The internal array storing the list's elements.
--- 
--- @field get fun(self: list, index: number): unknown Retrieves an element by its index.
--- @field replace fun(self: list, index: number, value: unknown) Replaces the value at the specified index.
--- @field insert fun(self: list, value: unknown, position: number|nil) Inserts a value at a specific position (or at the end if no position is specified).
--- @field remove fun(self: list, index: number|nil): unknown Removes and returns an element by index (or the last element if no index is specified).
--- 
--- @field index_of fun(self: list, search_value: unknown): number Returns the index of a given value, or `-1` if not found.
--- @field contains fun(self: list, search_value: unknown): boolean Checks if the list contains the given value.
--- @field length fun(self: list): number Returns the number of elements in the list.
--

--#endregion
