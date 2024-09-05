--- @meta
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            

--
--- @class Network
--- 
--- @field reserveChannel fun(name: string, options?: ChannelOptions)
--- @field registerListener fun(channel: string, listener: NetworkListener)
--- @field removeListener fun(channel: string, identifier: string, context?: Plugin)
--- @field triggerChannel fun(channel: string, arguments?: unknown[], context?: Plugin)
--

--
--- @class NetworkApi
--- 
--- @field registerChannelListener fun(self: Plugin, channel: string, listener: NetworkListener)
--- @field removeChannelListener fun(self: Plugin, channel: string, identifier: string)
--- @field triggerChannel fun(self: Plugin, channel: string, arguments?: unknown[])
--

--
--- @class ChannelOptions
--- 
--- @field owner? Plugin
--- @field internal? boolean
--- @field async? boolean
--

--
--- @class Channel : ChannelOptions, ListenerManager
--- 
--- @field name string
--

--
--- @class NetworkListener : Listener
--- 
--- @field owner? Plugin
--

--
--- @class ChannelReservation
--- 
--- @field name string
--- @field internal? boolean
--- @field async? boolean
--