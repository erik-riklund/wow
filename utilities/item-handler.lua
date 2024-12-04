
--[[~ Updated: 2024/12/01 | Author(s): Gopher ]]

--Backbone - A World of Warcraft Addon Framework
--Copyright (C) 2024 Erik Riklund (Gopher)
--
--This program is free software: you can redistribute it and/or modify it under the terms
--of the GNU General Public License as published by the Free Software Foundation, either
--version 3 of the License, or (at your option) any later version.
--
--This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
--without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
--See the GNU General Public License <https://www.gnu.org/licenses/> for more details.

---@param link string The item link string.
---@return number itemId The extracted item ID.
---Extracts the item ID from an item link.
backbone.getItemId = function (link) return link:match 'item:(%d+)' end

---@param item number|string The item ID or link.
---@return ItemData itemInfo A table containing detailed information about the item.
--- Retrieves detailed information about an item specified by its ID or link.
---* Combines basic and detailed item data into a structured format.
backbone.getItemInfo = function (item)
  ---@class ItemData
  local info = {}

  info.name,
  info.link,
  info.quality,
  info.baseItemLevel,
  info.requiredPlayerLevel,
  info.localizedType,
  info.localizedSubtype,
  info.stackCount,
  info.equipLocation,
  info.textureId,
  info.sellPrice,
  info.typeId,
  info.subtypeId,
  info.bindType,
  info.expansionId,
  info.setId,
  info.isCraftingReagent = C_Item.GetItemInfo (item)

  if info.link ~= nil then
    info.id = backbone.getItemId (info.link)
    info.itemLevel = backbone.getItemLevel (info.link)
  end

  return info
end

---@param info number|string The item link or ID for which to retrieve the item level.
---Retrieves the detailed item level of the specified item.
backbone.getItemLevel = function (info)
  return C_Item.GetDetailedItemLevelInfo (info)
end
