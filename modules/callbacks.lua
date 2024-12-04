---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/12/02 | Author(s): Gopher ]]

--Backbone - A World of Warcraft Addon Framework
--Copyright (C) 2024 Erik Riklund (Gopher)
--
--This program is free software: you can redistribute it and/or modify it under the terms
--of the GNU General Public License as published by the Free Software Foundation, either
--version 3 of the License, or (at your option) any later version.
--
--This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
--without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
--See the GNU General Public License <https://www.gnu.org/licenses/> for more details.

local queued_tasks = new 'Vector'

---@param task Task
---Executes a task immediately in a blocking manner.
---* Captures and logs errors if the task's callback fails.
backbone.executeTask = function (task)
  local success, exception = pcall(
    task.callback, (task.arguments and task.arguments:unpackElements()) or nil
  )
  if not success then print (exception) end -- TODO: improved error handling.
end

---@param task Task
---Schedules a task for asynchronous execution by adding it to the task queue.
backbone.executeTaskAsync = function (task) queued_tasks:insertElement (task) end

---A coroutine that processes tasks in the queue.
---* Limits execution time per frame to maintain a target of 60 FPS.
local task_process = coroutine.create(
  function ()
    local time_limit = 0.01667 -- Time budget per frame (60 FPS cap).

    while true do
      local time_started = GetTimePreciseSec()
      while queued_tasks:getSize() > 0 and (GetTimePreciseSec() - time_started <= time_limit) do
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
