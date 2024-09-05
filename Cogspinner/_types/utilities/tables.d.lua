--- @meta
--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--
--- Specifies which parts of a table should be considered "weak" for garbage collection purposes.
--- A weak reference allows the garbage collector to reclaim the associated object if the only
--- references are within the table itself, preventing memory leaks.
---
--- @alias WeakTableOptions 'key' | 'value' | 'both'
--

--
--- Creates an immutable (read-only) proxy for a given table, preventing modifications
--- to its contents (including nested tables).
--
--- @alias ImmutableTableProxy fun(target: table): table
--

--
--- Merges multiple tables into a single table, with later tables overriding values in earlier tables.
--
--- @alias TableMerger fun(base: table, extension: table, ...: table): table
--
