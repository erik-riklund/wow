--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, core.context
local addon, framework = ...

---
--- A queue of background tasks awaiting execution. Each task contains
--- a callback function and its associated arguments.
---
--- @type table<number, callbacks.backgroundTask>
---
local tasks = {}

---
--- A coroutine that processes background tasks in a controlled
--- manner to maintain a target frame rate.
---
--- @type thread
---
local process = coroutine.create(function()
  local frameLimit = 0.0167 -- target: 60fps

  while true do
    local initialized = GetTime()

    while #tasks > 0 do
      if (GetTime() - initialized) < frameLimit then
        --- @type callbacks.backgroundTask
        local currentTask = table.remove(tasks, 1)
        local success, result = pcall(currentTask.callback,
                                  unpack(currentTask.arguments))

        if not success then
          -- todo: implement error reporting.
        end
      end
    end

    coroutine.yield()
  end
end)

---
--- Resumes the background task processing coroutine if the queue has pending tasks.
---
local continueProcess = function()
  if #tasks > 0 then
    if coroutine.status(process) == 'suspended' then
      coroutine.resume(process)
    end
  end
end

---
--- Execute callbacks asynchronously by adding them to the background task queue for processing.
--- 
--- @type callbacks.executeCallbackAsync
---
local executeCallbackAsync = function(callback, arguments)
  table.insert(tasks, { callback = callback, arguments = arguments })
end

--
-- Expose the required functions to the framework context.
--
framework.export('callback/continue-process', continueProcess)
framework.export('callback/execute-async', executeCallbackAsync)
