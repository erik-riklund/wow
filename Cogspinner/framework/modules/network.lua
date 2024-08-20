--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            

local addon, context = ... --- @cast context core.context

--#region (context imports)

--- @type utility.collection.map
local map = context:import('utility/collection/map')

--- @type utility.collection.list
local list = context:import('utility/collection/list')

--- @type module.tasks
local task_process = context:import('module/tasks')

--#endregion

--
-- ?
--

--- @type module.network
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

context:export('module/network', network_controller)
