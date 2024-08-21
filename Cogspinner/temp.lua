local _, context = ... --- @cast context core.context

local frame = CreateFrame('Frame')
frame:RegisterEvent('PLAYER_ENTERING_WORLD')
frame:SetScript('OnEvent', function() collectgarbage() end)

local plugin = { id = 'test' }

--- @type module.network
local network = context:import('module/network')
network:reserve(plugin, { { name = 'JUST_TESTING' } })
network:monitor(plugin, 'JUST_TESTING', { callback = function(payload) print('Hello?') end })

network:transmit(plugin, 'JUST_TESTING')
