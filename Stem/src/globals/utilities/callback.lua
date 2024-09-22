--[[

  Project: Stem (framework)
  Utility: Callback Execution
  Version: 1.0.0

  Author(s): Erik Riklund
  Created: 2024/09/22 | Updated: 2024/09/22

  Description:
  Provides utilities for executing callbacks both synchronously and asynchronously. 
  This includes managing callback tasks and ensuring safe execution using `pcall`.

  Dependencies: 

  - validateArguments (for argument validation)
  - exception (for error handling)

  Notes:

  - Asynchronous tasks are processed within the frame limit to ensure performance.

]]

---
--- ?
---
--- @type task[]
---
local tasks = {}

---
--- Executes a callback function associated with an identifier. This function validates
--- the arguments, executes the callback safely, and handles errors that occur during
--- execution.
---
--- @param identifier  string     "A unique identifier for the callback."
--- @param callback    function   "The callback function to execute."
--- @param arguments?  unknown[]  "Optional arguments to pass to the callback."
---
_G.executeCallback = function(identifier, callback, arguments)
  --
  -- Validates the input arguments to ensure they are of the correct types.

  validateArguments {
    { label = 'identifier', value = identifier, types = 'string' },
    { label = 'callback', value = callback, types = 'function' },
    { label = 'arguments', value = arguments, types = 'array', optional = true },
  }

  -- Attempts to execute the callback function using `pcall`, passing the arguments.

  local success, result = pcall(callback, (arguments ~= nil and unpack(arguments)) or nil)

  -- If the callback execution fails, an error is raised.

  if not success then
    exception.generic('[Stem] Execution of callback "%s" failed. Reason: %s', identifier, result)
  end
end

---
--- Processes asynchronous tasks, ensuring that tasks are executed within a frame limit
--- for performance reasons. Uses coroutines and timers to manage execution time.
---
local process --[[@as thread]]
process = coroutine.create(function()
  --
  -- Defines the time limit per frame to ensure the task execution doesn't exceed 60fps.

  local frameLimit = 0.01667

  -- A continous loop to keep the process alive in the background.

  while true do
    --
    -- Records the start time to compare against the frame limit.

    local started = GetTime()

    -- Executes tasks within the frame time limit.

    while #tasks > 0 and ((GetTime() - started) <= frameLimit) do
      --
      -- Removes the first task from the queue and executes the callback.

      local task = table.remove(tasks, 1) --[[@as task]]
      executeCallback(task.identifier, task.callback, task.arguments)
    end

    -- If tasks remain, schedule the next processing loop after the frame limit delay.

    if #tasks > 0 then C_Timer.After(frameLimit, function() coroutine.resume(process) end) end

    -- Yields control back to the main program until resumed.

    coroutine.yield()
  end
end)

---
--- Queues a callback function for asynchronous execution. The callback is identified 
--- by a unique identifier and can optionally receive arguments. The task is executed 
--- when the coroutine resumes within the frame limit.
---
--- @param identifier  string     "A unique identifier for the callback."
--- @param callback    function   "The callback function to execute."
--- @param arguments?  unknown[]  "Optional arguments to pass to the callback."
---
_G.executeCallbackAsync = function(identifier, callback, arguments)
  --
  -- Adds the task to the queue for asynchronous execution.

  table.insert(tasks, { identifier = identifier, callback = callback, arguments = arguments } --[[@as task]])

  -- Resumes the coroutine if it's suspended, triggering the processing loop.

  if coroutine.status(process) == 'suspended' then coroutine.resume(process) end
end
