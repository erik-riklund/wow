---@type string, contextProvider
local addon, repository = ...
local api = repository.use 'api' --[[@as api]]
local frame = repository.use 'frame' --[[@as Frame]]

--[[~ Module: Task Manager ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/27

  This module provides functionality for handling callback tasks, allowing both 
  synchronous and asynchronous execution. It distributes asynchronous tasks 
  over multiple frames to ensure smooth performance and prevent frame drops.

  Features:

  - Execute callback tasks either synchronously or asynchronously.
  - Asynchronous tasks are processed in batches to avoid performance issues.
  - Built-in error handling for task execution.
  - Supports passing arguments to callback functions.

]]

---@type task[]
local tasks = {}

---
--- Executes a callback task immediately, with optional arguments. If an error occurs
--- during execution, it will be caught and logged in non-production environments.
---
---@param identifier string "A unique identifier for the callback task."
---@param callback   function "The function to be executed."
---@param arguments? unknown[] "(optional) Arguments to pass to the callback."
---
api.executeCallback = function(identifier, callback, arguments)
  xtype.validate {
    { 'identifier:string', identifier },
    { 'callback:function', callback },
    { 'arguments:array?', arguments },
  }

  local success, exception = pcall(callback, unpack(arguments or {}))

  if not success then
    local message = '<color=pale-red>Failed to execute callback <color=gainsboro>'
      .. "'$identifier'</color>:\n<color=wheat>$exception</color></color>"

    if xstring.hasPrefix(exception, { 'Interface/', 'Interface\\', '...' }) then
      exception = string.trim(xstring.getSubstringAfter(exception, ':', 2))
    end

    console.exception(message, { identifier = identifier, exception = exception })
  end
end

---
--- Queues a callback task for asynchronous execution. The task will be processed
--- in subsequent frames to distribute the workload and prevent frame drops.
---
---@param identifier string "A unique identifier for the callback task."
---@param callback   function "The function to be executed asynchronously."
---@param arguments? unknown[] "(optional) Arguments to pass to the callback."
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
  if #tasks > 0 and coroutine.status(process) == 'suspended' then coroutine.resume(process) end
end)
