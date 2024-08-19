--- @meta

--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--#region [type: task process]

--
--- Represents a mechanism for managing and executing a queue of tasks using a coroutine.
---
--- @class task.process
--- 
--- @field queue list The queue of tasks waiting to be executed.
--- @field controller? thread The coroutine handle responsible for processing the task queue.
--- 
--- @field enqueue fun(self: task.process, task: task) Adds a new task to the queue.
--- @field execute fun(self: task.process) Create the coroutine to process the task queue.
--

--#endregion

--#region [type: task]

--
--- Encapsulates a unit of work to be executed, including the callback function and its arguments.
--- 
--- @class task
--- 
--- @field callback function The function to be executed as the task.
--- @field arguments? unknown[] (Optional) The arguments to be passed to the callback function.
--

--#endregion