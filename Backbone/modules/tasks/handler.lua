---@type string, contextProvider
local addon, repository = ...
local api = repository.use 'api' --[[@as api]]
local frame = repository.use 'frame' --[[@as Frame]]

--[[~ Module: Task Management ~
  
  Version: 1.0.0 | Updated: 2024/09/25

  This module is responsible for scheduling and executing tasks in a way that ensures
  smooth frame rendering. It handles both synchronous and asynchronous execution of
  tasks, distributing workloads over multiple frames to avoid impacting performance.

  Developer's notes:

  - Tasks are executed either immediately or deferred across multiple frames using 
    the asynchronous mechanism. This keeps the game's frame rate stable even with 
    heavy task loads.
  
  Dependencies: xtype (for type validation)

]]

---@type task[]
local tasks = {}

---
--- Executes a callback immediately. If the callback fails, an error is caught and
--- the failure is logged. Optional arguments can be provided to the callback for
--- execution.
---
api.executeCallback = function(identifier, callback, arguments)
  xtype.validate {
    { 'identifier:string', identifier },
    { 'callback:function', callback },
    { 'arguments:array?', arguments },
  }

  -- Execute the callback and handle any errors that may occur. This ensures that
  -- even if the callback throws an exception, the framework will log the error and
  -- continue running without crashing.

  local success, exception = pcall(callback, unpack(arguments or {}))

  if not success then
    local message = '[Backbone] Callback execution failed for "%s":\n%s'
    print(string.format(message, identifier, exception))
  end
end

---
--- Queues a callback for asynchronous execution. The callback will be processed
--- in future frames to prevent overloading the current frame. This ensures smooth
--- rendering and defers heavy operations over time.
---
api.executeCallbackAsync = function(identifier, callback, arguments)
  -- Add the callback and its associated arguments to the task queue for deferred
  -- execution across multiple frames, helping distribute work to prevent frame rate drops.

  table.insert(
    tasks,
    { identifier = identifier, callback = callback, arguments = arguments }
  )
end

---
--- The coroutine-based task processor that executes tasks in batches, ensuring
--- that tasks are processed within the frame time limit, preserving smooth rendering
--- while allowing deferred operations.
---
local process = coroutine.create(function()
  local frameLimit = 0.01667 -- Target frame time to maintain 60 FPS.

  while true do
    local started = GetTime()

    -- Process tasks as long as there is time remaining in the current frame and
    -- there are pending tasks in the queue. This spreads out the work across
    -- multiple frames to avoid stalling the game.

    while #tasks > 0 and ((GetTime() - started) <= frameLimit) do
      local task = table.remove(tasks, 1) --[[@as task]]
      api.executeCallback(task.identifier, task.callback, task.arguments)
    end

    coroutine.yield() -- Yield control back to the game until the next frame.
  end
end)

---
--- The OnUpdate event handler triggers the coroutine each frame to process any
--- pending tasks. This ensures that the framework can perform deferred operations
--- while keeping the frame rate stable.
---
frame:SetScript('OnUpdate', function()
  if #tasks > 0 and coroutine.status(process) == 'suspended' then
    coroutine.resume(process)
  end
end)
