---@meta

---
--- ?
---
---@class network.api
---
---@field reserveChannel           network.api.reserveChannel
---@field registerChannelListener  network.api.registerChannelListener
---@field removeChannelListener    network.api.removeChannelListener
---@field invokeChannelListeners   network.api.invokeChannelListeners
---

---
--- ?
---
---@alias network.api.reserveChannel
---| fun(self: plugin, channel: string, options?: channel.options)
---

---
--- ?
---
---@alias network.api.registerChannelListener
---| fun(self: plugin, channel: string, listener: listener)
---

---
--- ?
---
---@alias network.api.removeChannelListener
---| fun(self: plugin, channel: string, identifier: string)
---

---
--- ?
---
---@alias network.api.invokeChannelListeners
---| fun(self: plugin, channel: string, payload?: unknown)
---
