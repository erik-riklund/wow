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
--- @field reserveChannel fun(name: string, options?: ChannelOptions, context?: string)
--- @field registerListener fun(channel: string, listener: Listener, context?: string)
--- @field removeListener fun(channel: string, identifier: string, context?: string)
--- @field triggerChannel fun(channel: string, arguments?: unknown[], context?: string)
--

--
--- @class NetworkApi
--- 
--- @field registerChannelListener fun(self: Plugin, channel: string, listener: Listener) Registers a listener function to the specified channel, allowing it to receive messages broadcast on that channel.
--- @field removeChannelListener fun(self: Plugin, channel: string, identifier: string) Unregisters a listener from a specific channel using its unique identifier.
--- @field triggerChannel fun(self: Plugin, channel: string, arguments?: unknown[]) Broadcasts a message on the specified channel, invoking all registered listeners with the provided arguments.
--

--
--- @class ChannelOptions
--- 
--- @field internal? boolean
--- @field async? boolean
--

--
--- @class Channel : ChannelOptions, ListenerManager
--- 
--- @field name string
--- @field owner? string
--

--
--- @class NetworkListener : Listener
--- 
--- @field owner? string
--

--
--- @class ChannelReservation
--- 
--- @field name string
--- @field internal? boolean
--- @field async? boolean
--