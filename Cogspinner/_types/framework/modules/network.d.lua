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
--- @class module.network
---
--- @field channels map
--- @field listeners map
---
--- @field reserve fun(self: module.network, owner: plugin.context, channels: network.reserve.options)
--- @field transmit fun(self: module.network, sender: plugin.context, channel_name: string, payload: table|nil)
--- @field monitor fun(self: module.network, reciever: plugin.context, channel_name: string, listener: network.monitor.options)
--- @field silence fun(self: module.network, reciever: plugin.context, channel_name: string, listener_id: string)
--

--#endregion

--#region [type: network channel]

--
--- ?
---
--- @class network.channel
---
--- @field name string
--- @field owner plugin.context
--- @field internal? boolean
--

--#endregion

--#region [type: channel reservation options]

---
--- ?
---
--- @class network.reserve.options
---
--- @field name string
--- @field internal? boolean
---

--#endregion

--#region [type: channel listener options]

--
--- ?
---
--- @class network.monitor.options
--- 
--- @field id? string
--- @field callback function
--

--#endregion

--#region [type: channel listener]

--
--- ?
---
--- @class network.listener
--- 
--- @field id? string
--- @field callback function
--- @field owner plugin.context
--

--#endregion
