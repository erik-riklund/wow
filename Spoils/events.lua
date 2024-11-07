---@class Spoils
local context = select(2, ...)

--[[~ Module: Events ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
context.plugin:registerEventListener('LOOT_OPENED', {
  persistent = false,
  callback = function() --
    context.lootFramePosition = { LootFrame:GetPoint() }
  end,
})

---
--- ?
---
context.plugin:registerEventListener('LOOT_OPENED', {
  callback = function()
    LootFrame:ClearAllPoints()
    -- LootFrame:SetClampedToScreen(false)
    -- LootFrame:SetPoint('TOPLEFT', UIParent, 'TOPRIGHT', 100, 0)
    LootFrame:SetPoint('TOP', UIParent, 'TOP', 0, 0)
    LootFrame:SetPoint('CENTER', UIParent, 'CENTER', 0, 0)

    if not backbone.hasPlugin 'Scavenger' then
      ---@type LootableSlot[]
      local slots = {}

      local slotCount = GetNumLootItems()
      for index = 1, slotCount do
        local info = backbone.getLootSlotInfo(index)
        slots[#slots + 1] = { index = index, info = info }
      end

      context.displayLoot(slots)
    end
  end,

  identifier = 'LOOT_OPENED',
})

---
--- ?
---
if backbone.hasPlugin 'Scavenger' then --
  context.plugin:registerChannelListener('LOOT_PROCESSED', {
    callback = function(slots)
      if #slots > 0 then context.displayLoot(slots) end
    end,

    identifier = 'LOOT_PROCESSED',
  })
end

---
--- ?
---
context.plugin:registerEventListener('LOOT_CLOSED', {
  callback = function()
    if context.lootFrame:IsShown() then
      context.lootFrame:SetShown(false) --
    end
  end,

  identifier = 'LOOT_CLOSED',
})
