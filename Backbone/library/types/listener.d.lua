---@meta

---@class Listener
---Represents an object that listens to a `Listenable` object (events, channels, etc.).
local listener =
{
  ---@type string?
  ---A unique identifier for the listener. (optional)
  ---* If omitted, the listener will be anonymous (not eligible for targeted removal).
  identifier = nil,

  ---@type function
  ---The callback function to be invoked when the listener is triggered.
  callback = nil,

  ---@type boolean?
  ---Indicates whether the listener should persist after being invoked. (optional)
  ---* If true, the listener remains active; if false, it is automatically removed after one invocation.
  ---* Defaults to true if not specified.
  persistent = nil
}
