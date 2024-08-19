--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            

local addon, context = ... --- @cast context core.context

--#region (context imports)

--- @type utilities.collections.map
local map = context:import('utilities/collections/map')

--- @type utilities.collections.list
local list = context:import('utilities/collections/list')

--- @type task.process
local task_process = context:import('modules/task-process')

--#endregion

--
-- ?
--

--- @type network.controller
local network_controller =
{
  --
  -- ?
  --

  channels = map()
}

--
-- ?
--

context:export('modules/network-controller', network_controller)
