--- @meta
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--

---
--- @class network.controller
--- 
--- @field reserveChannel fun(name: string, options?: network.channelOptions)
--- @field registerListener fun(channel: string, listener: listener, context?: plugin)
--- @field removeListener fun(channel: string, identifier: string, context?: plugin)
--- @field invokeChannel fun(name: string, payload?: unknown[], context?: plugin)
---

---
--- @class network.channelOptions
--- 
--- @field owner? string
--- @field internal? boolean
--- @field async? boolean
---

---
--- @class network.channel : listenerManager, network.channelOptions
---

---
--- @class network.api
--- 
--- @field invokeChannel fun(self: plugin, name: string, payload?: unknown[]) Invoke the specified channel, triggering its listeners and optionally passing a payload.
--- @field registerChannelListener fun(self: plugin, channel: string, listener: listener) Register a listener to the specified channel.
--- @field removeChannelListener fun(self: plugin, channel: string, identifier: string) Using its unique identifier, remove a listener from the specified channel.
---
