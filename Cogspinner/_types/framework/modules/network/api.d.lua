--- @meta
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            

--#region [type: network controller API]

--
--- @class NetworkControllerApi
---
--- @field context? PluginContext
---
--- @field Listen fun(self: NetworkControllerApi, options: NetworkControllerApi.ListenerOptions)
--- @field Silence fun(self: NetworkControllerApi, options: NetworkControllerApi.ListenerRemovalOptions)
--- @field Transmit fun(self: NetworkControllerApi, options: NetworkControllerApi.TransmissionOptions)
--

--#endregion

--#region [type: listener options]

--
--- @class NetworkControllerApi.ListenerOptions
--- 
--- @field channel string
--- @field callback NetworkController.ListenerCallback
--- 
--- @field identifier? string
--

--#endregion

--#region [type: listener removal options]

--
--- @class NetworkControllerApi.ListenerRemovalOptions
--- 
--- @field channel string
--- @field identifier string
--

--#endregion

--#region [type: transmission options]

--
--- @class NetworkControllerApi.TransmissionOptions
--- 
--- @field channel string
--- @field payload? unknown
--

--#endregion
