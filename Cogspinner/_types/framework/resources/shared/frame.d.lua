--- @meta

--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--#region [type: shared frame controller]

--
--- Represents a controller for a shared frame, handling
--- registration and execution of update handlers.
---
--- @class resource.shared.frame
---
--- @field frame Frame The underlying frame object.
--- @field update_handlers list A list of functions to be called on each frame update.
--- 
--- @field register fun(self: resource.shared.frame, update_handler: function) Registers a new update handler.
--

--#endregion
