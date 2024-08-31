--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string, FrameworkContext
local addon, context = ...

--#region (locally scoped variables/functions)

local coroutine      = _G.coroutine

--#endregion

--#region (framework context imports)

local frame          = context:import('core/frame') --[[@as CoreFrame]]
local list           = context:import('collection/list') --[[@as ListConstructor]]

--#endregion

--
-- This module manages a queue of tasks and processes them in a time-sliced
-- manner using a coroutine to avoid impacting frame rate.
--

--- @type TaskHandler
local TaskHandler    =
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

  RegisterTask = function(self, task)
    self.queue:Insert(task)

    if not self.controller then
      self:CreateBackgroundProcess()
    end
  end,

  --
  -- Creates and starts the coroutine to process the task queue.
  -- It processes tasks in a loop, respecting a frame time limit
  -- to avoid causing performance issues.
  --

  CreateBackgroundProcess = function(self)
    if self.controller == nil then
      --#region: Coroutine initialization
      --| We create the coroutine here, rather than at the module level,
      --| to ensure it's only created when needed, saving resources.
      --#endregion

      self.controller = coroutine.create(
        function()
          --#region (locally scoped variables/functions)

          local process     = self
          local pcall       = _G.pcall
          local time        = _G.time
          local type        = _G.type
          local unpack      = _G.unpack

          --#endregion

          local frame_limit = 0.0166 --#note: 60fps

          while true do
            local started = time()

            while process.queue:Length() > 0 and (time() - started) < frame_limit do
              --#region: Task execution and error handling
              --| We remove and execute the first task in the queue, using `pcall`
              --| for safe execution, and handle potential errors gracefully.
              --#endregion

              local task = process.queue:Remove(1) --[[@as Task]]
              local success = pcall(task.callback,
                (type(task.arguments) == 'table' and unpack(task.arguments)) or nil
              )

              if not success then
                -- todo: implement error handling!
              end
            end

            coroutine.yield()
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

frame:RegisterUpdateHandler(
  function()
    if coroutine.status(TaskHandler.controller) == 'suspended' then
      if TaskHandler.queue:Length() > 0 then
        coroutine.resume(TaskHandler.controller)
      end
    end
  end
)

--
-- Exports the `task_process` object to the framework context,
-- allowing other modules to enqueue tasks for execution.
--

context:export('module/tasks', TaskHandler)
