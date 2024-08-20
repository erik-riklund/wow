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
--- Creates a new list instance, optionally initialized with the given values.
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
--- @field values unknown[]
--- 
--- @field get fun(self: list, index: number): unknown Retrieves an element from the list by its index.
--- @field replace fun(self: list, index: number, value: unknown) Sets the value of an element in the list at a specific index.
--- @field insert fun(self: list, value: unknown, position: number|nil) Inserts an element into the list at the specified position, or the end if no position is provided.
--- @field remove fun(self: list, index: number|nil): unknown Removes an element from the list at the specified index, or the last element if no index is provided.
--- @field length fun(self: list): number Returns the number of elements in the list.
--

--#endregion
