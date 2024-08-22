--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            

local _, context = ... --- @cast context core.context

--#region (context imports)

--- @type module.tasks
local tasks = context:import('module/tasks')

--- @type module.network
local network = context:import('module/network')

--- @type resource.shared.frame
local frame = context:import('resource/shared/frame')

--#endregion


