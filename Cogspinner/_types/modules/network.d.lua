--- @meta
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--

---
--- @class network.channel.options
--- 
--- @field owner? plugin
--- @field internal? boolean
--- @field async? boolean
---

---
--- @class network.channel : library.listenerManager, network.channel.options
---

---
--- ?
--- 
--- @alias network.reserveChannel fun(name: string, options?: network.channel.options)
---

---
--- ?
---
--- @alias network.registerListener fun(channel: string, listener: listener, context?: plugin)
---

---
--- ?
---
--- @alias network.removeListener fun(channel: string, identifier: string, context?: plugin)
---

---
--- ?
---
--- @alias network.invokeChannel fun(name: string, payload?: unknown[], context?: plugin)
---
