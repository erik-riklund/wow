--- @meta
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            

--#region [type: core frame]

--
--- @class CoreFrame
--- 
--- @field frame Frame The underlying frame object.
--- 
--- @field updateHandlers List A list of functions to be called on each frame update.
--- @field registerUpdateHandler fun(self: CoreFrame, callback: function) Registers a new update handler.
--- 
--- @field events Map A list of events that the frame is registered to listen to.
--- @field eventHandlers List A list of functions to be called when an event occur.
--- @field registerEventHandler fun(self: CoreFrame, callback: fun(event: string, ...)) Registers a new event handler function.
--- @field registerEvent fun(self: CoreFrame, event: string) Registers the frame to listen for a specific event.
--- @field unregisterEvent fun(self: CoreFrame, event: string) Unregisters the frame from listening to a specific event.
--

--#endregion
