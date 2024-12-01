
--[[~ Updated: 2024/11/26 | Author(s): Gopher ]]

---@return number item_count The total count of lootable items.
---Returns the number of items currently available in the loot window.
backbone.getLootCount = function () return GetNumLootItems() end

---@param slot number The index of the loot slot (1-based).
---@return LootslotInfo slot_info A table containing detailed information about the specified loot slot.
---Retrieves detailed information about a specific loot slot.
---* Combines data from multiple APIs into a structured format.
backbone.getLootslotInfo = function (slot)
  ---@class LootslotInfo
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

---Returns true if the loot window is related to fishing.
---* Calls the underlying `IsFishingLoot` API.
backbone.isFishingLoot = function () return IsFishingLoot() end

---@param slot number The index of the loot slot to loot (1-based).
--- Loots the specified slot in the loot window.
---* Calls the underlying `LootSlot` API to claim the loot.
backbone.lootSlot = function (slot) LootSlot (slot) end
