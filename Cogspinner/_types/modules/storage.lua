--- @meta

--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--#region (type: storage.options)

--- @class storage.options
--- @field account boolean?
--- @field character boolean?

--#endregion

--#region (type: storage.instance)

--- @class storage.instance
--- @field data map<string, unknown>
--- @field get fun(self: storage.instance, variable_path: string): unknown "?"
--- @field set fun(self: storage.instance, variable_path: string, value: unknown) "?"
--- @field drop fun(self: storage.instance, variable_path: string) "?"
--- @field resolve fun(self: storage.instance, variable_path: string, build_mode: boolean): table|nil, string

--#endregion
