local _, context = ...
--- @cast context core.context

local frame = CreateFrame('Frame')
frame:RegisterEvent('PLAYER_ENTERING_WORLD')
frame:SetScript('OnEvent', function() collectgarbage() end)


