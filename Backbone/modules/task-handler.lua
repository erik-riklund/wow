---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/11/19 | Author(s): Gopher ]]

local queued_tasks = new 'Vector'

---@param task Task The task object containing a callback and optional arguments.
---Executes a task immediately in a blocking manner.
---* Captures and logs errors if the task's callback fails.
backbone.executeTask = function (task)
  local success, exception = pcall(
    task.callback, (task.arguments and task.arguments:unpackElements()) or nil
  )
  if not success then context.plugin:error (exception) end
end

---@param task Task The task object to schedule for later execution.
---Schedules a task for asynchronous execution by adding it to the task queue.
backbone.executeTaskAsync = function (task) queued_tasks:insertElement (task) end

---A coroutine that processes tasks in the queue.
---* Limits execution time per frame to maintain a target of 60 FPS.
local task_process = coroutine.create(
  function ()
    local time_limit = 0.01667 -- Time budget per frame (60 FPS cap).

    while true do
      local time_started = B_Time.precise()
      while queued_tasks:getSize() > 0 and (B_Time.precise() - time_started <= time_limit) do
        backbone.executeTask (queued_tasks:removeElement(1) --[[@as Task]])
      end

      coroutine.yield() -- Pause execution until the next frame.
    end
  end
)

---Hooks into the frame's `OnUpdate` event to process queued tasks.
---* Resumes the task-processing coroutine if there are tasks in the queue.
context.frame:HookScript(
  'OnUpdate', function ()
    if queued_tasks:getSize() > 0 then
      if coroutine.status(task_process) == 'suspended' then coroutine.resume(task_process) end
    end
  end
)
