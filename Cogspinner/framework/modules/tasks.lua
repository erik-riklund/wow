--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local co = coroutine
local _, context = ... --- @cast context core.context

--#region (context imports)

--- @type utility.collection.list
local list = context:import('utility/collection/list')

--- @type resource.shared.frame
local shared_frame = context:import('resources/shared/frame')

--#endregion

--
-- This module manages a queue of tasks and processes them in a time-sliced
-- manner using a coroutine to avoid impacting frame rate.
--

--- @type module.tasks
local task_process =
{
  --
  -- A queue to store tasks that need to be executed. We use a list
  -- for efficient insertion and extraction.
  --

  queue = list(),

  --
  -- The coroutine handle (created on demand) that
  -- will process the tasks in the queue.
  --

  controller = nil,

  --
  -- Enqueues a task to be executed later. If the coroutine has not
  -- been initialized, it's created to begin processing the queue.
  --

  enqueue = function(self, task)
    self.queue:insert(task)

    if not self.controller then self:execute() end
  end,

  --
  -- Creates and starts the coroutine to process the task queue.
  -- It processes tasks in a loop, respecting a frame time limit
  -- to avoid causing performance issues.
  --

  execute = function(self)
    if self.controller == nil then
      --#region: Coroutine initialization
      -- We create the coroutine here, rather than at the module level,
      -- to ensure it's only created when needed, saving resources.
      --#endregion

      self.controller = co.create(
        function()
          local frame_limit = 0.0166 --#note: 60fps
          local process, pcall, time, type, unpack = self, pcall, GetTime, type, unpack

          while true do
            local started = time()

            while process.queue:length() > 0 and (time() - started) < frame_limit do
              --#region: Task execution and error handling
              -- We remove and execute the first task in the queue, using `pcall`
              -- for safe execution, and handle potential errors gracefully.
              --#endregion

              local task = process.queue:remove(1) --[[@as task]]
              local success = pcall(task.callback,
                (type(task.arguments) == 'table' and unpack(task.arguments)) or nil
              )

              if not success then
                --#todo: implement error handling!
              end
            end

            co.yield()
          end
        end
      )
    end
  end
}

--
-- Registers a function to be called on each frame update. This function will
-- check if the task processing coroutine is suspended and has tasks pending, 
-- and resume it if so.
--

shared_frame:register(
  function()
    if co.status(task_process.controller) == 'suspended' then
      if task_process.queue:length() > 0 then
        co.resume(task_process.controller)
      end
    end
  end
)

--
-- Exports the `task_process` object to the framework context,
-- allowing other modules to enqueue tasks for execution.
--

context:export('module/tasks', task_process)
