---@meta

---
--- Represents a communication channel that listens to incoming events and sends messages.
--- Each channel may be associated with a plugin and can be configured through options.
---
---@class channel : listener, channel.options
---@field context? plugin "An optional plugin instance associated with this channel."
---

---
--- Configuration options for a communication channel. These options control behavior
--- such as asynchronous processing and internal messaging.
---
---@class channel.options
---
---@field async?     boolean "If true, the channel operates asynchronously."
---@field internal?  boolean "Marks the channel for internal use, isolating it from external communication."
---
