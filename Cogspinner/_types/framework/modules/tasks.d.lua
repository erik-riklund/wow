--- @meta
--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--#region [type: task process]

--
--- @class TaskHandler
--- 
--- @field queue List The queue of tasks waiting to be executed.
--- @field controller? thread The coroutine handle responsible for processing the task queue.
--- 
--- @field RegisterTask fun(self: TaskHandler, task: Task) Adds a new task to the queue.
--- @field CreateBackgroundProcess fun(self: TaskHandler) Create the coroutine used to process the queue of tasks.
--

--#endregion

--#region [type: task]

--
--- @class Task
--- 
--- @field callback function The function to be executed as the task.
--- @field arguments? unknown[] (optional) The arguments to be passed to the callback function.
--

--#endregion