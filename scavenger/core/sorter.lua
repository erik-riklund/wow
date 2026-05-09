--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
--   github.com/erik-riklund/wow/scavenger/core (2026)

---@class context
local x = select(2, ...)

---------------------------------------------------------------------
-- ?

local slot_type_order = {
  Enum.LootSlotType.Money,
  Enum.LootSlotType.Currency,
  Enum.LootSlotType.Item
}

---------------------------------------------------------------------
-- ?

local item_type_order = {
  { Enum.ItemClass.Miscellaneous, Enum.ItemMiscellaneousSubclass.Mount },
  { Enum.ItemClass.Miscellaneous, Enum.ItemMiscellaneousSubclass.CompanionPet },
  { Enum.ItemClass.Weapon,        nil },
  { Enum.ItemClass.Armor,         nil },
  { Enum.ItemClass.Tradeskill,    nil }
}

---------------------------------------------------------------------
-- ?

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
      for position, slot_type in ipairs(slot_type_order) do
        if slot_type == slot.type then return position end
      end
      return #slot_type_order + 1 -- ?
    end
  },

  -- ?

  {
    test = function(slot)
      return slot.item ~= nil and slot.type == Enum.LootSlotType.Item
    end,

    calculate = function(slot)
      return 8 - slot.item["quality"] -- ?
    end
  },

  -- ?

  {
    test = function(slot)
      return slot.item ~= nil and slot.type == Enum.LootSlotType.Item
    end,

    calculate = function(slot)
      for position, entry in ipairs(item_type_order) do
        local type_id, subtype_id = unpack(entry)
        if type_id == slot.item["type_id"] then
          if subtype_id == nil or subtype_id == slot.item["subtype_id"] then
            return position -- ?
          end
        end
      end

      return #item_type_order + 1 -- ?
    end
  },

  -- ?

  {
    test = function(slot)
      if slot.type == Enum.LootSlotType.Item then
        return slot.item ~= nil and slot.item["quality"] > Enum.ItemQuality.Poor and (
          slot.item["type_id"] == Enum.ItemClass.Armor or slot.item["type_id"] == Enum.ItemClass.Weapon
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
        return slot.item ~= nil and slot.item["quality"] == Enum.ItemQuality.Poor
      end
    end,

    calculate = function(slot)
      return 0 - (slot.quantity * slot.item["sell_value"])
    end
  }
}

---------------------------------------------------------------------
-- ?

Scavenger.add_event_hook(
  "LOOT_PROCESSED", function(slots)
    local sorted_slots = {}

    for _, slot in ipairs(slots) do
      if not slot.autolooted then
        table.insert(sorted_slots, slot)
      end
    end

    table.sort(
      sorted_slots, function(slot_a, slot_b)
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
    )

    x.invoke_listeners("LOOT_SORTED", sorted_slots)
  end
)
