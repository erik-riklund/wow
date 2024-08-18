--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local _, context = ... --- @cast context core.context

--#region (context imports)

--- @type utilities.collections.list
local list = context:import('utilities/collections/list')

--#endregion

--
-- ?
--

--- @type task.process
local task_process =
{
  --
  -- ?
  --

  queue = list(),

  --
  -- ?
  --

  
}

--
-- ?
--

--- @type task.handler
local task_handler =
{
  --
  -- ?
  --

  process = nil,

  --
  -- ?
  --


}

--
-- ?
--

context:export('modules/task-handler', task_handler)
