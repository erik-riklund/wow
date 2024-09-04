--- @meta
--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--
--- @class List
---
--- @field values? unknown[] The underlying array storing the list's elements.
--- @field getElementAt fun(self: List, index: number): unknown Retrieves the element at the specified `index`.
--- @field find fun(self: List, searchValue: unknown): number  Finds the first index of the `searchValue` in the list, or -1 if not found.
--- @field insert fun(self: List, value: unknown, position: number|nil) Inserts a `value` at the specified `position`, or at the end of the list if `position` is nil.
--- @field removeElementAt fun(self: List, position: number|nil): unknown Removes and returns the element at the specified `position`, or the last element if `position` is nil.
--- @field size fun(self: List): number Returns the number of elements in the list.
--

--
-- Factory function for creating new list objects, an ordered collection of elements,
-- with optional initial values and support for 'weak' table behavior.
--
--- @alias ListConstructor fun(values?: unknown[], options?: { weak: Table.WeakOptions }): List
--

--
--- @class Record
---
--- @field entries? table<RecordKey, unknown> The internal table storing the key-value pairs.
--- @field get fun(self: Record, key: RecordKey): unknown Retrieves the value associated with the given key.
--- @field entryExists fun(self: Record, key: RecordKey): boolean Checks if a key exists in the record.
--- @field set fun(self: Record, key: RecordKey, value: unknown) Sets or updates the value for the given key.
--- @field remove fun(self: Record, key: RecordKey) Removes the key-value pair with the given key.
--

--
--- Factory function for creating new record objects. It allows optional initialization with existing
--- key-value pairs and supports 'weak' table behavior for memory management in certain scenarios.
--
--- @alias RecordConstructor fun(entries?: table<RecordKey, unknown>, options?: { weak: Table.WeakOptions }): Record
--

--
--- Defines the allowed data types for keys within a Record object.
---
--- @alias RecordKey string | table
--