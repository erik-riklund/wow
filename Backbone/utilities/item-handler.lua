
--[[~ Updated: 2024/11/26 | Author(s): Gopher ]]

---
--- ?
---
B_Item = {}

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
  local info = {}

  info.name,
  info.link,
  info.quality,
  info.base_ilevel,
  info.required_player_level,
  info.localized_type,
  info.localized_subtype,
  info.stack_count,
  info.equip_location,
  info.texture_id,
  info.sell_price,
  info.type_id,
  info.subtype_id,
  info.bind_type,
  info.expansion_id,
  info.set_id,
  info.crafting_reagent = C_Item.GetItemInfo (item)

  if info.link ~= nil then
    info.id = B_Item.getID (info.link)
    info.ilevel = B_Item.getLevel (info.link)
  end

  return info
end

---
--- ?
---
---@param info ItemInfo
---
B_Item.getLevel = function (info)
  return C_Item.GetDetailedItemLevelInfo (info)
end
