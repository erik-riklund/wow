---@class Spoils
local context = select(2, ...)

--[[~ Module: Loot Handler ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---@type LootFrame
context.lootFrame = _G['SpoilsLootFrame']

---
--- ?
---
context.lootFrame:HookScript('OnShow', function()
  context.lootFrame:ClearAllPoints()
  context.lootFrame:SetPoint(unpack(context.lootFramePosition))
end)

---
--- ?
---
---@param slots LootableSlot[]
---
context.displayLoot = function(slots)
  DevTools_Dump(slots)

  -- ?

  context.lootFrame:SetShown(true)
end
