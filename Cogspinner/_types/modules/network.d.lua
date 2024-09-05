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
--- @field reserveChannel fun(options: Channel)
--- @field registerListener fun(listener: NetworkListener)
--- @field removeListener fun(identifier: string, owner: Plugin|nil)
--- @field transmit fun(content: NetworkTransmission)
--

--
--- @class Channel
--- 
--- @field name string
--- @field owner? Plugin
--- @field internal? boolean
--- @field async? boolean
--

--
--- @class NetworkListener : Listener
--- 
--- @field owner? Plugin
--

--
--- @class NetworkTransmission
--- 
--- @field channel string
--- @field sender? Plugin
--- @field payload? unknown
--