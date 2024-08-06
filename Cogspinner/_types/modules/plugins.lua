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
--- @field id string
--- @field data plugin.storage
--- @field onload fun(self: plugin, callback: function)
--- @field listen fun(self: plugin, options: event.listener.options)
--- @field silence fun(self: plugin, event: string, callback_id: string?)

--#endregion

--#region (type: plugin.options)

--- @class plugin.options
--- @field storage storage.options?

--#endregion

--#region (type: plugin.storage)

--- @class plugin.storage
--- @field account storage.instance
--- @field character storage.instance

--#endregion
