---@meta

---@class Task
---Represents a unit of work to be executed, either synchronously or asynchronously.
local task =
{
  ---@type string?
  ---A unique identifier for the task.
  identifier = nil,

  ---@type function
  ---The callback function to be executed when the task runs.
  callback = nil,

  ---@type Vector?
  ---Optional arguments to pass to the callback function when the task is executed.
  arguments = nil
}
