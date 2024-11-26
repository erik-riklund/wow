---@meta

---
---@class Listener
---Represents an object that listens to events on a channel.
local listener =
{
  ---@type string?
  ---A unique identifier for the listener.
  identifier = nil,

  ---@type function
  ---The callback function to be invoked when the listener is triggered.
  callback = nil,

  ---@type boolean?
  ---Indicates whether the listener should persist after being invoked.
  ---* If `true`, the listener remains active; if `false`, it is automatically removed after one invocation.
  ---* Defaults to `true` if not specified.
  persistent = nil
}
