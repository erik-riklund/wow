--- @meta
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--

---
--- @class network.channelOptions
--- 
--- @field owner? plugin
--- @field internal? boolean
--- @field async? boolean
---

---
--- @class channel.listenerManager : listenerManager, network.channelOptions
---

---
--- Registers a new channel, enforcing name uniqueness.
--- 
--- @alias network.reserveChannel fun(name: string, options?: network.channelOptions)
---

---
--- Registers a listener to the specified channel, verifying channel
--- existence and, if protected, caller authorization.
---
--- @alias network.registerListener fun(channel: string, listener: listener, context?: plugin)
---

---
--- Using its unique identifier, remove a listener from the specified channel.
---
--- @alias network.removeListener fun(channel: string, identifier: string, context?: plugin)
---

---
--- Invokes the specified channel, triggering its listeners and optionally
--- passing a payload. The caller's context is verified to ensure only the
--- owning context can invoke the channel.
---
--- @alias network.invokeChannel fun(name: string, payload?: unknown[], context?: plugin)
---

---
--- @class network.pluginApi
--- 
--- @field invokeChannel fun(self: plugin, name: string, payload?: unknown[]) Invoke the specified channel, triggering its listeners and optionally passing a payload.
--- @field registerChannelListener fun(self: plugin, channel: string, listener: listener) Register a listener to the specified channel.
--- @field removeChannelListener fun(self: plugin, channel: string, identifier: string) Using its unique identifier, remove a listener from the specified channel.
---
