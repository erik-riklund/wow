---@type string, contextProvider
local addon, repository = ...
local api = repository.use 'api' --[[@as api]]
local frame = repository.use 'frame' --[[@as Frame]]

--[[~ Module: Task Management ~

  Version: 1.0.0 | Updated: 2024/09/26

  This module handles the execution of tasks in both synchronous and asynchronous modes. Tasks are
  queued for asynchronous execution to prevent the overloading of a single frame, which helps maintain
  smooth gameplay performance. It also manages the processing of tasks within frame time limits to
  ensure consistent frame rates.

]]

---@type task[]
local tasks = {}

---
--- Executes a callback function immediately. If an error occurs during the execution 
--- of the callback, it is caught and logged, along with the identifier of the task.
---
---@param identifier string "A unique identifier for the callback task."
---@param callback function "The function to be executed."
---@param arguments? unknown[] "Optional arguments to pass to the callback."
---
api.executeCallback = function(identifier, callback, arguments)
  xtype.validate {
    { 'identifier:string', identifier },
    { 'callback:function', callback },
    { 'arguments:array?', arguments },
  }

  local success, exception = pcall(callback, unpack(arguments or {}))

  if not success then
    local message = '[Backbone] Callback execution failed for "%s":\n%s'

    if xstring.hasPrefix(exception, 'Interface/') or xstring.hasPrefix(exception, '...') then
      -- todo: extract the error message!
    end

    print(string.format(message, identifier, exception))
  end
end

---
--- Queues a callback task for asynchronous execution. The task will be processed 
--- in subsequent frames to distribute the workload and prevent frame drops.
---
---@param identifier string "A unique identifier for the callback task."
---@param callback function "The function to be executed asynchronously."
---@param arguments? unknown[] "Optional arguments to pass to the callback."
---
api.executeCallbackAsync = function(identifier, callback, arguments)
  table.insert(tasks, { identifier = identifier, callback = callback, arguments = arguments })
end

---
--- A coroutine-based task processor that runs within the frame's `OnUpdate` script.
--- It processes tasks within the frame time limit (targeting 60 FPS) to ensure smooth 
--- rendering. Tasks are executed in small batches until the time limit is reached.
---
local process = coroutine.create(function()
  local frameLimit = 0.01667 -- Target frame time to maintain 60 FPS.

  while true do
    local started = GetTime()

    while #tasks > 0 and ((GetTime() - started) <= frameLimit) do
      local task = table.remove(tasks, 1) --[[@as task]]
      api.executeCallback(task.identifier, task.callback, task.arguments)
    end

    coroutine.yield()
  end
end)

---
--- The `OnUpdate` handler for the frame that checks for pending tasks and resumes 
--- the coroutine to process them. This ensures that asynchronous tasks are executed 
--- in the background without affecting frame rate.
---
frame:SetScript('OnUpdate', function()
  if #tasks > 0 and coroutine.status(process) == 'suspended' then
    coroutine.resume(process)
  end
end)
