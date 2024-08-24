--- @meta

--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--#region [type: network controller]

--
--- Manages communication channels between plugins, handling channel
--- reservation, transmission, and listener registration.
---
--- @class module.network
---
--- @field channels map
--- @field listeners map
---
--- @field reserve fun(self: module.network, owner: table, channels: network.reserve.channel[]) Reserves channels for a plugin.
--- @field transmit fun(self: module.network, sender: table, channel_name: string, payload: table|nil) Transmits a message on a channel.
--- @field monitor fun(self: module.network, reciever: table, channel_name: string, listener: network.monitor.listener) Registers a listener to a channel.
--- @field silence fun(self: module.network, reciever: table, channel_name: string, listener_id: string) Unregisters a listener from a channel.
--

--#endregion

--#region [type: network channel]

--
--- Represents a communication channel with an owner and optional privacy settings.
---
--- @class network.channel
---
--- @field name string The unique name of the channel.
--- @field owner table The plugin that owns the channel.
--- @field internal? boolean Whether the channel is internal to the owner plugin (default: false).
--

--#endregion

--#region [type: channel reservation options]

---
--- Options for reserving a channel, specifying its name and whether it is internal.
---
--- @class network.reserve.channel
---
--- @field name string The name of the channel to reserve.
--- @field internal? boolean Whether the channel should be internal to the owning plugin (default: false).
---

--#endregion

--#region [type: channel listener]

--
--- Represents a function registered to receive messages on a channel.
---
--- @class network.listener
--- 
--- @field id? string (optional) A unique identifier for the listener.
--- @field callback network.listener.callback The function to be called when a message is received.
--- @field owner table The plugin that registered the listener.
--

--#endregion

--#region [type: listener options]

--
--- Options for registering a listener, specifying its
--- callback function and an optional identifier.
---
--- @class network.monitor.listener
--- 
--- @field id? string (optional) A unique identifier for the listener.
--- @field callback network.listener.callback The function to be called when a message is received.
--

--#endregion

--#region [type: listener callback]

---
--- A function that is called when a message is received on a channel.
--- 
--- @alias network.listener.callback fun(payload: table|nil)
--- 

--#endregion
