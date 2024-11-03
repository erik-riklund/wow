---@class Spoils
local context = select(2, ...)

--[[~ Module: Loot Frame ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

-- ---@type BackboneDismissableFrame
-- context.frame = _G['SpoilsLootFrame']

-- ---
-- --- ?
-- ---
-- context.plugin:registerEventListener('LOOT_OPENED', {
--   callback = function()
--     LootFrame:SetClampedToScreen(false)
--     LootFrame:SetPoint('TOPLEFT', UIParent, 'TOPRIGHT', 100, 0)
--   end,
-- })

-- ---
-- --- ?
-- ---
-- context.plugin:registerChannelListener('LOOT_PROCESSED', {
--   identifier = 'lootHandler',
--   ---@param slots LootableSlot[]
--   callback = function(slots) context.frame:SetShown(true) end,
-- })

-- ---
-- --- ?
-- ---
-- context.plugin:registerEventListener('LOOT_CLOSED', {
--   callback = function()
--     if context.frame:IsShown() then context.frame:SetShown(false) end
--   end,
-- })
