--[[~ Module: ? ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
---@param slot number
---
backbone.getLootSlotInfo = function(slot)
  local lootIcon, --
    lootName,
    lootQuantity,
    currencyId,
    lootQuality,
    isLocked,
    isQuestItem,
    questId,
    isActive =
    --
    GetLootSlotInfo(slot)

  ---@class LootSlotInfo
  local lootSlotInfo = {
    icon = lootIcon,
    name = lootName,
    link = GetLootSlotLink(slot),
    quantity = lootQuantity,
    isLocked = isLocked,
    isQuestItem = isQuestItem,
    slotType = GetLootSlotType(slot),
    currencyId = currencyId,
  }

  return lootSlotInfo
end
