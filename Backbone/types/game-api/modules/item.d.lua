---@meta

---
---@class C_Item
---
C_Item = {}

---
--- Returns info for an item.
---
---@type fun(item: number|string): name: string, link: string, quality: number, item_level: number, required_level: number, item_type: string, item_subtype: string, stack_count: number, equip_location: string, texture: number, sell_price: number, class_id: number, subclass_id: number, bind_type: number, expansion_id: number, set_id: number?, crafting_reagent: boolean
---
C_Item.GetItemInfo = function (item) end

---
--- ?
---
---@type fun(item_info: number|string): actual_item_level: number, preview_level: boolean, sparse_item_level: number
---
C_Item.GetDetailedItemLevelInfo = function (item_info) end
