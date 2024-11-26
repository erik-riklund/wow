
--[[~ Updated: 2024/11/26 | Author(s): Gopher ]]

--- A utility module for interacting with the game's loot system.
B_Loot = {}

---@return number item_count The total count of lootable items.
---Returns the number of items currently available in the loot window.
B_Loot.getItemCount = function () return GetNumLootItems () end

---@param slot number The index of the loot slot (1-based).
---@return LootSlotInfo slot_info A table containing detailed information about the specified loot slot.
---Retrieves detailed information about a specific loot slot.
---* Combines data from multiple APIs into a structured format.
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

---@param slot number The index of the loot slot to loot (1-based).
--- Loots the specified slot in the loot window.
---* Calls the underlying `LootSlot` API to claim the loot.
B_Loot.lootSlot = function (slot) LootSlot (slot) end
