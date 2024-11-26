---@meta

---@class ChannelOptions
---Defines configuration options for a channel.
local channel_options = {}

---@type boolean?
---Indicates if the channel is internal.
---* Internal channels are restricted to the owning plugin.
---* Defaults to `true` if not specified.
channel_options.internal = nil

---@type boolean?
---Indicates if listeners on the channel should be invoked asynchronously.
---* Defaults to `true` if not specified.
channel_options.async = nil
