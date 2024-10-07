---@type string, Repository
local addon, repository = ...

--[[~ Module: Tasks ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/07

  Manages execution of tasks for the framework, supporting both synchronous and
  asynchronous callbacks. Asynchronous tasks are queued and processed within frame
  time limits to maintain performance (60+ FPS).

]]

---@type Task[]
local tasks = {}

---
--- Executes the provided callback, passing the specified arguments if any are provided.
---
---@param identifier string
---@param callback function
---@param arguments? unknown[]
---
backbone.executeCallback = function(identifier, callback, arguments)
  if type(arguments) ~= 'table' then arguments = {} end

  ---@type boolean, string
  local success, exception = pcall(callback, unpack(arguments))

  if not success then
    -- todo: implement error reporting.
  end
end

---
--- Queues the provided callback for asynchronous execution.
---
---@param identifier string
---@param callback function
---@param arguments? unknown[]
---
backbone.executeCallbackAsync = function(identifier, callback, arguments)
  table.insert(tasks, { id = identifier, callback = callback, arguments = arguments })
end

-- The coroutine used to asynchronously process queued tasks while maintaining performance.
-- To possibly avoid long-running operations to cause lockups or lag, executions are resumed
-- on the next frame if the specified time limit is reached.

local process = coroutine.create(function()
  local frameLimit = 0.01667 -- target: 60fps

  while true do
    local started = GetTime()

    while #tasks > 0 and (GetTime() - started <= frameLimit) do
      local task = table.remove(tasks, 1) --[[@as Task]]
      backbone.executeCallback(task.id, task.callback, task.arguments)
    end

    coroutine.yield()
  end
end)

-- Resumes the coroutine when there are tasks queued and it's not already active.

repository.frame:SetScript('OnUpdate', function()
  if coroutine.status(process) == 'suspended' then
    if #tasks > 0 then coroutine.resume(process) end
  end
end)
