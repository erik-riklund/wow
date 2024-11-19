---@class Backbone
local context = select(2, ...)

--[[~ Task manager (module) ~
  Updated: 2024/11/19 | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
local queued_tasks = new 'Vector'

---
--- ?
---
---@param task Task
---
backbone.executeTask = function(task)
  local success, result =
    pcall(task.callback, (task.arguments and task.arguments:unpackElements()) or nil)

  if not success then print(result) end -- TODO: implement better error handling!
end

---
--- ?
---
---@param task Task
---
backbone.executeTaskAsync = function(task) queued_tasks:insertElement(task) end

---
--- ?
---
local task_process = coroutine.create(function()
  local time_limit = 0.01667 -- maintain 60 FPS

  while true do
    local time_started = GetTime()

    while queued_tasks:getSize() > 0 and (GetTime() - time_started <= time_limit) do
      backbone.executeTask(queued_tasks:removeElement(1) --[[@as Task]])
    end

    coroutine.yield()
  end
end)

---
--- ?
---
context.frame:HookScript('OnUpdate', function()
  if queued_tasks:getSize() > 0 then
    if coroutine.status(task_process) == 'suspended' then
      coroutine.resume(task_process)
    end
  end
end)
