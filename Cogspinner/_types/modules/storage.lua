--- @meta

--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--#region (type: storage.api)

--- @class storage.api
--- 
--- @field account storage.unit
--- @field character storage.unit

--#endregion

--#region (type: storage.unit)

--- @class storage.unit
--- 
--- @field data record<string, unknown>
--- 
--- @field get fun(self: storage.unit, variable_path: string): unknown
--- @field set fun(self: storage.unit, variable_path: string, value: unknown)
--- @field drop fun(self: storage.unit, variable_path: string)
--- @field resolve fun(self: storage.unit, variable_path: string, build_mode: boolean): table | nil, string

--#endregion
