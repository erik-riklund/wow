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
--- @field ReserveChannels fun(self: NetworkController, options: NetworkController.ReservationOptions)
--- @field RegisterListener fun(self: NetworkController, options: NetworkController.ListenerRegistrationOptions)
--- @field UnregisterListener fun(self: NetworkController, options: NetworkController.ListenerRemovalOptions)
--- @field TransmitPayload fun(self: NetworkController, options: NetworkController.TransmissionOptions)
--

--#endregion

--#region [type: channel reservation options]

--
--- ?
---
--- @class NetworkController.ReservationOptions
---
--- @field owner PluginContext
--- @field channels { name: string, internal?: boolean }[]
--

--#endregion

--#region [type: listener registration options]

--
--- @class NetworkController.ListenerRegistrationOptions
---
--- @field channel string
--- @field reciever PluginContext
--- @field callback NetworkController.ListenerCallback
---
--- @field identifier? string
--

--#endregion

--#region [type: listener removal options]

--
--- @class NetworkController.ListenerRemovalOptions
---
--- @field channel string
--- @field reciever PluginContext
--- @field identifier string
--

--#endregion

--#region [type: transmission options]

--
--- @class NetworkController.TransmissionOptions
---
--- @field channel string
--- @field sender PluginContext
--- @field payload? unknown
--

--#endregion

--#region [type: channel]

--
--- @class NetworkController.Channel
---
--- @field owner PluginContext
--- @field internal boolean
--

--#endregion

--#region [type: listener callback]

---
--- @alias NetworkController.ListenerCallback fun(payload: unknown|nil)
---

--#endregion

--#region [type: listener]

--
--- @class NetworkController.Listener
---
--- @field owner PluginContext
--- @field callback NetworkController.ListenerCallback
--- @field identifier? string
--

--#endregion
