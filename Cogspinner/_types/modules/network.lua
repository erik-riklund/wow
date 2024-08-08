--- @meta

--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            

--#region (type: network.api)

--- @class network.api
--- 
--- @field context plugin
--- 
--- @field transmit fun(self: network.api, channel: string, payload: unknown?)
--- @field recieve fun(self: network.api, channel: string, callback: function)

--#endregion

--#region (type: network.channel)

--- @class network.channel
--- 
--- @field owner plugin
--- @field listeners list

--#endregion