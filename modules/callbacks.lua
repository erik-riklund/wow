---@class Backbone
local context = select(2, ...)

--[[~ Updated: 2024/12/05 | Author(s): Gopher ]]

--Backbone - A World of Warcraft addon framework
--Copyright (C) 2024 Erik Riklund (Gopher)
--
--This program is free software: you can redistribute it and/or modify it under the terms
--of the GNU General Public License as published by the Free Software Foundation, either
--version 3 of the License, or (at your option) any later version.
--
--This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
--without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
--See the GNU General Public License <https://www.gnu.org/licenses/> for more details.

local queuedTasks = new 'Vector'

-- FRAMEWORK API --

---@param task Task
---Executes a task synchronously. Useful for tasks that need to be executed immediately.
---
backbone.executeTask = function (task)
  local success, exception = pcall (task.callback,
    (task.arguments and task.arguments:unpackElements()) or nil
  )
  if success == false then
    print (string.format('[Backbone] Task failed (%s): %s', task.id or 'anonymous', exception))
  end
end

---@param task Task
---Executes a task asynchronously. Useful for tasks that are not required to be executed immediately.
---
backbone.executeBackgroundTask = function (task)
  queuedTasks:insertElement (task)
end

-- TASK CONTROLLER --

local process = coroutine.create (
  function ()
    local limit = 0.01667 -- 60fps
    
    while true do
      local started = GetTimePreciseSec()

      while queuedTasks:getSize () > 0 and (GetTimePreciseSec() - started < limit) do
        backbone.executeTask (queuedTasks:removeElement (1) --[[@as Task]])
      end

      coroutine.yield()
    end
  end
)

context.frame:HookScript(
  'OnUpdate', function ()
    if queuedTasks:getSize () > 0 then
      if coroutine.status (process) == 'suspended' then
        coroutine.resume (process) -- resume the task controller.
      end
    end
  end
)
