--[[~ ? (?) ~
  Updated: 2024/11/20 | Author(s): Erik Riklund (Gopher)
]]

---
--- Retrieves detailed information about a specific loot slot,
--- including item icon, name, quantity, quality, and type.
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
