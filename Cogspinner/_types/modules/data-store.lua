--- @meta

--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--#region (type: storage_instance)

--- @class storage_instance
--- @field data map<string, unknown>
--- @field get fun(self: storage_instance, variable: string): unknown
--- @field set fun(self: storage_instance, variable: string, value: unknown)
--- @field drop fun(self: storage_instance, variable: string)

--#endregion
