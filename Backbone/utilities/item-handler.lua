
--[[~ Updated: 2024/11/26 | Author(s): Gopher ]]

---
--- ?
---
_G.B_Item = {}

---
--- Returns the item ID from the provided item link.
---
---@param link string
---@return number
---
B_Item.getID = function (link) return link:match 'item:(%d+)' end

---
--- Retrieves detailed information about an item specified by its ID or link.
---
---@param item number|string
---
B_Item.getInfo = function (item)
  ---@class ItemData
  local itemInfo = {}

  itemInfo.name,
  itemInfo.link,
  itemInfo.quality,
  itemInfo.baseItemLevel,
  itemInfo.requiredPlayerLevel,
  itemInfo.itemType,
  itemInfo.itemSubType,
  itemInfo.stackCount,
  itemInfo.equipLocation,
  itemInfo.texture,
  itemInfo.sellPrice,
  itemInfo.itemTypeId,
  itemInfo.itemSubTypeId,
  itemInfo.bindType,
  itemInfo.expansionId,
  itemInfo.setId,
  itemInfo.isCraftingReagent = C_Item.GetItemInfo (item)

  if itemInfo.link ~= nil then
    itemInfo.id = B_Item.getID (itemInfo.link)
    itemInfo.itemLevel = C_Item.GetDetailedItemLevelInfo (itemInfo.link)
  end

  return itemInfo
end
