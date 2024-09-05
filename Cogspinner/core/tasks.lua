--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string, Context
local addon, framework       = ...

local controller
local coroutine              = _G.coroutine

local setTimer               = C_Timer.After
local createList             = framework.import('collection/list') --[[@as ListConstructor]]

--
-- Provides a task queue with a coroutine-based task processor to
-- execute tasks in the background without impacting frame rate.
--
local tasks                  = createList()

--
-- The coroutine that will process tasks from the queue. It yields
-- periodically to allow other code to run and maintain responsiveness.
--
--- @type thread
--
controller                   = coroutine.create(
  function()
    local GetTime    = _G.GetTime
    local pcall      = _G.pcall
    local unpack     = _G.unpack

    local frameLimit = 0.0167 -- 60fps

    while true do
      if tasks:size() > 0 then
        --~ Process tasks within the frame time limit.

        local initiated = GetTime()
        while tasks:size() > 0 and (GetTime() - initiated < frameLimit) do
          --~ Execute the next task from the queue and handle potential errors.

          local task = tasks:removeElementAt(1) --[[@as BackgroundTask]]
          local success, result = pcall(task.callback, unpack(task.arguments))

          if not success then
            -- todo: how do we want to handle error reporting?
          end
        end
      end

      if tasks:size() > 0 then
        --~ Schedule a timer to resume the coroutine when there are more
        --~ tasks to process, ensuring we don't block the main thread.

        setTimer(
          frameLimit * 0.1,

          function()
            coroutine.resume(controller)
          end
        )
      end

      coroutine.yield()
    end
  end
)

--
-- This function adds new tasks to the queue. It validates the callback and
-- resumes the coroutine if necessary to ensure prompt task processing.
--
--- @type BackgroundTaskHandler
--
local registerBackgroundTask = function(callback, arguments)
  if type(callback) ~= 'function' then
    exception('Invalid argument type for "callback". Expected a function.')
  end

  tasks:insert(
    {
      callback = callback,
      arguments = arguments or {}

    } --[[@as BackgroundTask]]
  )

  if coroutine.status(controller) == 'suspended' then
    coroutine.resume(controller)
  end
end

--
-- Exports the task registration function, exposing it to other framework modules.
--
framework.export('core/tasks', registerBackgroundTask)
