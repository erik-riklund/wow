local _, context = ...
--- @cast context core.context

local frame = CreateFrame('Frame')
frame:RegisterEvent('PLAYER_ENTERING_WORLD')
frame:SetScript('OnEvent', function() collectgarbage() end)

--- @type resources.shared.frame
-- local shared_frame = context:import('resources/shared/frame')
-- shared_frame:register(function() print('?') end)

--- @type task.process
-- local task_process = context:import('modules/task-process')
-- task_process:enqueue({ callback = function() print('Hello world') end })


