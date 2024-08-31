--- @meta
--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--#region [type: immutable table function]

--
--
--- Creates a proxy table that mirrors the given table but prevents any modifications
--- to its contents. This provides a read-only view of the original table, useful for
--- protecting data structures from accidental or unwanted changes.
---
--- @alias ImmutableTable fun(target: table): table
--

--#endregion

--#region [type: immutable table proxy]

--
--- @class ImmutableTableProxy
--- 
--- @field __newindex fun() Throws an error when a write operation is attempted on the proxy table.
--- @field __index fun(self: table, key: unknown): unknown Retrieves the value associated with the given key, recursively making nested tables immutable.
--

--#endregion
