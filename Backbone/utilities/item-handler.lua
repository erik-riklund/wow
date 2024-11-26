
--[[~ Updated: 2024/11/26 | Author(s): Gopher ]]

---A utility module for interacting with item data in the game.
B_Item = {}

---@param link string The item link string.
---@return number item_id The extracted item ID.
--- Extracts the item ID from an item link.
B_Item.getID = function (link) return link:match 'item:(%d+)' end

---@param item number|string The item ID or link.
---@return ItemData item_info A table containing detailed information about the item.
--- Retrieves detailed information about an item specified by its ID or link.
---* Combines basic and detailed item data into a structured format.
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

---@param info ItemInfo The item link or ID for which to retrieve the item level.
--- Retrieves the detailed item level of the specified item.
B_Item.getLevel = function (info) return C_Item.GetDetailedItemLevelInfo (info) end
