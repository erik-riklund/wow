---@meta

---
---@class Channel : ChannelOptions, Listenable
---
local channel = {}

---
--- ?
---
---@type Plugin
---
channel.owner = nil

---
--- ?
--- 
---@type string
---
channel.name = nil

---
---@class ChannelOptions
---
local channel_options = {}

---
--- ?
---
---@type boolean?
---
channel_options.internal = nil

---
--- ?
---
---@type boolean?
---
channel_options.async = nil
