--[[~ Updated: 2024/12/08 | Author(s): Gopher ]]

--Backbone - A World of Warcraft addon framework
--Copyright (C) 2024 Erik Riklund (Gopher)
--
--This program is free software: you can redistribute it and/or modify it under the terms
--of the GNU General Public License as published by the Free Software Foundation, either
--version 3 of the License, or (at your option) any later version.
--
--This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
--without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
--See the GNU General Public License <https://www.gnu.org/licenses/> for more details.

---@return number item_count
---Returns the number of items currently available in the loot window.
---
backbone.getLootCount = function ()
  return GetNumLootItems()
end

---@param slot number
---@return Backbone.LootSlotInfo slotInfo
---Retrieves detailed information about a specific loot slot.
---* Combines data from multiple APIs into a structured format.
---
backbone.getLootSlotInfo = function (slot)
  ---@class Backbone.LootSlotInfo
  local info = {}

  info.icon,
  info.name,
  info.quantity,
  info.currencyId,
  info.quality,
  info.locked,
  info.isQuestItem,
  info.questId,
  info.isQuestActive = GetLootSlotInfo (slot)
  
  info.slotType = GetLootSlotType (slot)
  info.link = GetLootSlotLink (slot)

  return info
end

---Returns true if the loot window is related to fishing.
---* Calls the underlying `IsFishingLoot` API.
---
backbone.isFishingLoot = function ()
  return IsFishingLoot()
end

---@param slot number
--- Loots the specified slot in the loot window.
---* Calls the underlying `LootSlot` API to claim the loot.
---
backbone.lootSlot = function (slot) LootSlot (slot) end
