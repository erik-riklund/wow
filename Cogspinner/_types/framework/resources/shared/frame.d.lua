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
--- 
--- @field update_handlers list A list of functions to be called on each frame update.
--- @field register_update_handler fun(self: resource.shared.frame, callback: function) Registers a new update handler.
--- 
--- @field events map A list of events that the frame is registered to listen to.
--- @field event_handlers list A list of functions to be called when an event occur.
--- @field register_event_handler fun(self: resource.shared.frame, callback: function) Registers a new event handler function.
--- @field register_event fun(self: resource.shared.frame, event_name: string) Registers the frame to listen for a specific event.
--- @field unregister_event fun(self: resource.shared.frame, event_name: string) Unregisters the frame from listening to a specific event.
--

--#endregion
