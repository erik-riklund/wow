--- @meta
--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--#region [type: network controller]

--
--- ?
---
--- @class NetworkController
---
--- @field channels Map
--- @field listeners Map
---
--- @field ReserveChannels fun(self: NetworkController, options: Channel.ReservationOptions)
--- @field RegisterListener fun(self: NetworkController, options: Channel.ListenerRegistrationOptions)
--- @field UnregisterListener fun(self: NetworkController, options: Channel.ListenerRemovalOptions)
--- @field TransmitPayload fun(self: NetworkController, options: Channel.TransmissionOptions)
--

--#endregion

--#region [type: channel reservation options]

--
--- ?
---
--- @class Channel.ReservationOptions
---
--- @field owner PluginContext
--- @field channels { name: string, internal?: boolean }[]
--

--#endregion

--#region [type: channel]

--
--- ?
---
--- @class Channel
--- 
--- @field owner PluginContext
--- @field internal boolean
--

--#endregion

--#region [type: listener callback]

---
--- A function that is called when a message is received on a channel.
--- 
--- @alias Channel.ListenerCallback fun(payload?: unknown)
--- 

--#endregion

--#region [type: listener]

--
--- ?
---
--- @class Channel.Listener
--- 
--- @field owner PluginContext
--- @field callback Channel.ListenerCallback
--- @field identifier? string
--

--#endregion

--#region [type: listener registration options]

--
--- ?
---
--- @class Channel.ListenerRegistrationOptions
--- 
--- @field channel string
--- @field reciever PluginContext
--- @field callback Channel.ListenerCallback
--- 
--- @field identifier? string
--

--#endregion

--#region [type: listener removal options]

--
--- ?
---
--- @class Channel.ListenerRemovalOptions
--- 
--- @field channel string
--- @field reciever PluginContext
--- @field identifier string
--

--#endregion

--#region [type: transmission options]

--
--- ?
---
--- @class Channel.TransmissionOptions
--- 
--- @field channel string
--- @field sender PluginContext
--- @field payload? unknown
--

--#endregion
