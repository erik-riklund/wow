
--[[~ Updated: 2024/11/26 | Author(s): Gopher ]]

---
--- ?
---
B_Loot = {}

---
--- Returns the number of items in the loot window.
---
B_Loot.getItemCount = function () return GetNumLootItems () end

---
--- Retrieves detailed information about a specific loot slot.
---
---@param slot number
---
B_Loot.getSlotInfo = function (slot)
  ---@class LootSlotInfo
  local info = {}

  info.icon,
  info.name,
  info.quantity,
  info.currency_id,
  info.quality,
  info.locked,
  info.quest_item,
  info.quest_id,
  info.quest_active = GetLootSlotInfo (slot)
  
  info.slot_type = GetLootSlotType (slot)
  info.link = GetLootSlotLink (slot)

  return info
end

---
--- Loots the specified slot.
--- 
---@param slot number
---
B_Loot.lootSlot = function (slot) LootSlot (slot) end
