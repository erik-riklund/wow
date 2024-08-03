--- @meta

--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--#region (type: plugin)

--- ?
--- @class plugin
--- @field id string "The unique identifier for the plugin."
--- @field data plugin.storage "?"
--- @field onload fun(self: plugin, callback: function)

--#endregion

--#region (type: plugin.storage)

--- @class plugin.storage

--#endregion

--#region (type: plugin.create.options)

--- @class plugin.create.options
--- @field storage storage.options?

--#endregion
