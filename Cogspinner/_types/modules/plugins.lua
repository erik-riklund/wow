--- @meta

--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--#region (type: plugin)

--- @class plugin
--- 
--- @field id string
--- @field data storage.api
--- @field event event.api
--- @field network network.api
--- 
--- @field onload fun(self: plugin, callback: function)

--#endregion

--#region (type: plugin.options)

--- @class plugin.options
--- 
--- @field channels list<string>?

--#endregion
