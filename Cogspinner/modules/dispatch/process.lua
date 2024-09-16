--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, framework.context
local addon, framework = ...

--- @type Frame
local frame = framework.import('core/frame')

---
--- Maintains a queue for background tasks, with each task encapsulating
--- a callback function and its associated arguments.
---
--- @type table<number, dispatch.backgroundTask>
---
local tasks = {}

---
--- A coroutine that processes background tasks in a controlled manner, thereby
--- maintaining a target frame rate and ensuring smooth UI performance.
---
--- @type thread
---
local process = coroutine.create(function()
  local frameLimit = 0.0167 -- target: 60fps

  while true do
    local initialized = GetTime()

    while #tasks > 0 do
      if (GetTime() - initialized) < frameLimit then
        --- @type dispatch.backgroundTask
        local currentTask = table.remove(tasks, 1)
        local success, result = pcall(currentTask.callback, unpack(currentTask.arguments))

        if not success then
          -- todo: implement error reporting.
        end
      end
    end

    coroutine.yield()
  end
end)

---
--- Attaches a script to the frame's 'OnUpdate' event to resume the background
--- task processing coroutine if there are pending tasks and the coroutine is
--- currently suspended. This ensures tasks are processed efficiently within the
--- frame rate constraints.
---
frame:SetScript('OnUpdate', function()
  if coroutine.status(process) == 'suspended' and #tasks > 0 then
    coroutine.resume(process)
  end
end)

---
--- Executes callbacks asynchronously by adding them to the background task queue,
--- allowing for potential non-blocking execution of time-consuming operations.
--- 
--- @type dispatch.executeCallbackAsync
---
local executeCallbackAsync = function(callback, arguments)
  table.insert(tasks, { callback = callback, arguments = arguments })
end

--
framework.export('dispatch/execute-async', executeCallbackAsync)
