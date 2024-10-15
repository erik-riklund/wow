--[[~ Module: Callback Handler ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0 | Updated: ?

]]

---@type Task[]
local queuedTasks = {}

---
--- ?
---
---@param task Task
backbone.executeCallback = function(task)
  print 'backbone.executeCallback: not implemented.' --
end

---
--- ?
---
---@param task Task
backbone.executeCallbackAsync = function(task)
  queuedTasks[#queuedTasks + 1] = task --
end

---
--- ?
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
--- ?
backbone.sharedFrame:HookScript('OnUpdate', function()
  if #queuedTasks > 0 and coroutine.status(process) == 'suspended' then
    coroutine.resume(process)
  end
end)
