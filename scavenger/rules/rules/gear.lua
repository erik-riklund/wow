--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger/rules (2026)

---@class context
local x = select(2, ...)

--
-- # ?
--
-- ...
--

local function get_inventory_slot_id(equip_location)
  local slot_ids = {
    INVTYPE_HEAD           = INVSLOT_HEAD,
    INVTYPE_SHOULDER       = INVSLOT_SHOULDER,
    INVTYPE_BODY           = INVSLOT_BODY,
    INVTYPE_CHEST          = INVSLOT_CHEST,
    INVTYPE_ROBE           = INVSLOT_CHEST,
    INVTYPE_WAIST          = INVSLOT_WAIST,
    INVTYPE_LEGS           = INVSLOT_LEGS,
    INVTYPE_FEET           = INVSLOT_FEET,
    INVTYPE_WRIST          = INVSLOT_WRIST,
    INVTYPE_HAND           = INVSLOT_HAND,
    INVTYPE_CLOAK          = INVSLOT_BACK,
    INVTYPE_WEAPON         = INVSLOT_MAINHAND,
    INVTYPE_2HWEAPON       = INVSLOT_MAINHAND,
    INVTYPE_WEAPONMAINHAND = INVSLOT_MAINHAND,
    INVTYPE_WEAPONOFFHAND  = INVSLOT_OFFHAND,
    INVTYPE_HOLDABLE       = INVSLOT_OFFHAND,
    INVTYPE_SHIELD         = INVSLOT_OFFHAND,
    INVTYPE_RANGED         = INVSLOT_RANGED,
    INVTYPE_TABARD         = INVSLOT_TABARD
  }
  return slot_ids[equip_location] or error(
    string.format("Invalid equip location: %s", tostring(equip_location))
  )
end

--
-- # ?
--
-- ...
--

scavenger.register_loot_rule(
  {
    test = function(slot)
      if slot.type == Enum.LootSlotType.Item and type(slot.item) == "table" then
        if slot.item.sell_value > 0 and slot.item.bind_type == Enum.ItemBind.OnAcquire then
          return slot.item.type_id == Enum.ItemClass.Weapon or (
            slot.item.type_id == Enum.ItemClass.Armor and
            slot.item.subtype_id ~= Enum.ItemArmorSubclass.Generic
          )
        end
      end
    end,

    evaluate = function(slot)
      local item = slot.item
      local inventory_slot_id = get_inventory_slot_id(item.equip_location)
      local equipped_item_level = C_Item.GetDetailedItemLevelInfo(
        GetInventoryItemLink("player", inventory_slot_id)
      )

      if equipped_item_level - item.actual_level >= 5 and item.is_collected then
        return true -- ?
      end
    end
  }
)
