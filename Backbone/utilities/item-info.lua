
--[[~ Updated: 2024/11/20 | Author(s): Erik Riklund (Gopher) ]]

---
--- Returns the item ID from the provided item link.
---
---@param itemLink string
---@return number
---
backbone.getItemId = function(itemLink) return itemLink:match 'item:(%d+)' end

---
--- Retrieves detailed information about an item specified by its ID or link.
---
---@param item number|string
---
backbone.getItemInfo = function(item)
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
  itemInfo.isCraftingReagent = C_Item.GetItemInfo(item)

  if itemInfo.link ~= nil then
    itemInfo.id = backbone.getItemId(itemInfo.link)
    itemInfo.itemLevel = C_Item.GetDetailedItemLevelInfo(itemInfo.link)
  end

  return itemInfo
end
