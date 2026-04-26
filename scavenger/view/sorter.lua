--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger/view (2026)

local _, this = ...

---------------------------------------------------------------------
-- ?
--

local score_handlers = {
  -- ?

  {
    test = function(slot)
      return slot.is_quest_item
    end,

    calculate = function(slot) return 0 end
  },

  -- ?

  {
    test = function(slot)
      return true -- ?
    end,

    calculate = function(slot)
      for position, slot_type in ipairs(this.slot_type_order) do
        if slot_type == slot.type then return position end
      end
      return #this.slot_type_order + 1 -- ?
    end
  },

  -- ?

  {
    test = function(slot)
      local item = slot.item
      return item and slot.type == Enum.LootSlotType.Item
    end,

    calculate = function(slot)
      local item = slot.item
      return 8 - item.quality -- ?
    end
  },

  -- ?

  {
    test = function(slot)
      local item = slot.item
      return item and slot.type == Enum.LootSlotType.Item
    end,

    calculate = function(slot)
      local item = slot.item
      for position, entry in ipairs(this.item_type_order) do
        local type_id, subtype_id = unpack(entry)
        if type_id == item.type_id then
          if subtype_id == nil or subtype_id == item.subtype_id then
            return position -- ?
          end
        end
      end
      return #this.item_type_order + 1 -- ?
    end
  },

  -- ?

  {
    test = function(slot)
      if slot.type == Enum.LootSlotType.Item then
        local item = slot.item
        return item and item.quality > Enum.ItemQuality.Poor and (
          item.type_id == Enum.ItemClass.Armor or item.type_id == Enum.ItemClass.Weapon
        )
      end
    end,

    calculate = function(slot)
      return 5000 - slot.item["actual_level"] -- ?
    end
  },

  -- ?

  {
    test = function(slot)
      if slot.type == Enum.LootSlotType.Item then
        local item = slot.item
        return item and item.quality == Enum.ItemQuality.Poor
      end
    end,

    calculate = function(slot)
      return 0 - (slot.quantity * slot.item["sell_price"])
    end
  }
}

---------------------------------------------------------------------
-- ?
--

this.sort = function(first_slot, second_slot)
  local slot_a = unpack(first_slot)
  local slot_b = unpack(second_slot)

  for _, handler in ipairs(score_handlers) do
    local score_a = nil
    if handler.test(slot_a) then
      score_a = handler.calculate(slot_a)
    end

    local score_b = nil
    if handler.test(slot_b) then
      score_b = handler.calculate(slot_b)
    end

    if score_a ~= nil or score_b ~= nil then
      score_a = score_a or score_b + 1
      score_b = score_b or score_a + 1

      if score_a ~= score_b then
        return score_a < score_b -- ?
      end
    end
  end

  return (slot_a and slot_b) and (
    (slot_a.name or "unknown") < (slot_b.name or "unknown")
  )
end
