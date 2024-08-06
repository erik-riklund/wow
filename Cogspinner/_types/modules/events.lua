--- @meta

--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--#region (type: event.trigger)

--- @alias event.trigger 'once'|'all'

--#endregion

--#region (type: event.listener.options)

--- @class event.listener.options
--- @field event string
--- @field callback function
--- @field callback_id string?
--- @field trigger event.trigger?

--#endregion

--#region (type: event.listener)

--- @class event.listener
--- @field plugin_id string
--- @field callback function
--- @field callback_id string?
--- @field trigger event.trigger?

--#endregion
