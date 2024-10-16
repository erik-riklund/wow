--[[~ Module: Callback Handler ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: ?

]]

---@type Task[]
local queuedTasks = {}

---
--- Executes the provided task by invoking its callback with the provided arguments.
--- Displays an error message if the callback fails.
---
---@param task Task
backbone.executeCallback = function(task)
  local success, exception = pcall(task.callback, unpack(task.arguments or {}))
  if not success then backbone.displayErrorMessage(exception) end
end

---
--- Queues the provided task for asynchronous execution.
---
---@param task Task
backbone.executeCallbackAsync = function(task) queuedTasks[#queuedTasks + 1] = task end

---
--- The coroutine that processes queued tasks within the frame time limit, ensuring 
--- smooth performance at 60 fps by executing tasks within the allotted time.
---
local process = coroutine.create(function()
  local frameLimit = 0.01667 -- 60 fps

  while true do
    local timeStarted = GetTime()

    while #queuedTasks > 0 do
      if (GetTime() - timeStarted) <= frameLimit then
        backbone.executeCallback(table.remove(queuedTasks, 1) --[[@as Task]])
      end
    end

    coroutine.yield()
  end
end)

---
--- Hooks into the `OnUpdate` event to resume the task processing
--- coroutine if there are tasks queued for execution.
---
backbone.sharedFrame:HookScript('OnUpdate', function()
  if #queuedTasks > 0 and coroutine.status(process) == 'suspended' then
    coroutine.resume(process)
  end
end)
