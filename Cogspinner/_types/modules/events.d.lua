--- @meta
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            

--
--- @class EventHandler
--- 
--- @field registerListener fun(eventName: string, listener: Listener, context?: string)
--- @field removeListener fun(eventName: string, identifier: string, context?: string)
--- @field invokeEvent fun(eventName: string, ...: unknown)
--

--
--- @class EventHandlerApi
--- 
--- @field onInitialize fun(self: Plugin, callback: function) Register a callback function to be executed once when the plugin is fully loaded.
--- @field registerEventListener fun(self: Plugin, event: string, listener: Listener) Register a listener function for a specific game event.
--- @field removeEventListener fun(self: Plugin, event: string, identifier: string) Remove a previously registered event listener.
--

--
--- @class Event : ListenerManager
--

--
--- @class EventListener : Listener
--- 
--- @field owner? string
--
