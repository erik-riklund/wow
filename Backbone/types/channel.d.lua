---@meta

---
---@class Channel : ChannelOptions, Listenable
---Represents a communication channel that allows plugins to manage and notify listeners.
---* Inherits from `ChannelOptions` and `Listenable`.
local channel =
{
  ---@type Plugin
  ---The plugin that owns this channel.
  owner = nil,

  ---@type string
  ---The unique name of the channel.
  name = nil
}
