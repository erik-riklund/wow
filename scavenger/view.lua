local _, context = ...

-- ?
local slot_type_order = {
  Enum.LootSlotType.Money,
  Enum.LootSlotType.Currency,
  Enum.LootSlotType.Item
}

-- ?
local item_type_order = {
  {
    Enum.ItemClass.Miscellaneous,
    Enum.ItemMiscellaneousSubclass.Mount
  },
  {
    Enum.ItemClass.Miscellaneous,
    Enum.ItemMiscellaneousSubclass.CompanionPet
  },

  { Enum.ItemClass.Weapon,     nil },
  { Enum.ItemClass.Armor,      nil },
  { Enum.ItemClass.Tradeskill, nil }
}


local score_handlers =
{
  -- ?
  {
    test = function (slot)
      return slot.is_quest_item
    end,

    calculate = function (slot) return 0 end
  },

  -- ?
  {
    test = function (slot) return true end,

    calculate = function (slot)
      for position, slot_type in ipairs(slot_type_order) do
        if slot_type == slot.type then return position end
      end
      return #slot_type_order + 1 -- Unrecognized categories are placed last.
    end
  },

  -- ?
  {
    test = function (slot)
      return type(slot.item) == "table"
         and slot.type == Enum.LootSlotType.Item
    end,

    calculate = function (slot) return 8 - slot.item.quality end
  },

  -- ?
  {
    test = function (slot)
      return type(slot.item) == "table"
         and slot.type == Enum.LootSlotType.Item
    end,

    calculate = function (slot)
      for position, entry in ipairs(item_type_order) do
        local type_id, subtype_id = unpack(entry)
        if type_id == slot.item.type_id then
          if subtype_id == nil or subtype_id == slot.item.subtype_id then
            return position -- Lower position = higher priority.
          end
        end
      end
      return #item_type_order + 1 -- Unlisted categories are placed last.
    end
  },

  -- Sorts non-poor armor and weapons by item level, subtracting the item level
  -- from 5000 to invert the values (higher item level yields a lower score).
  {
    test = function (slot)
      if slot.type == Enum.LootSlotType.Item then
        return type(slot.item) == "table"
           and slot.item.quality > Enum.ItemQuality.Poor
           and (
            slot.item.type_id == Enum.ItemClass.Armor or
            slot.item.type_id == Enum.ItemClass.Weapon
           )
      end
    end,

    calculate = function (slot) return 5000 - slot.item.actual_level end
  },

  -- Multiplies quantity by sell value and subtracts it from 0 to yield negative
  -- values to ensure that the most lucrative stack of junk gets the lowest score.
  {
    test = function (slot)
      return slot.type == Enum.LootSlotType.Item
         and type(slot.item) == "table"
         and slot.item.quality == Enum.ItemQuality.Poor
    end,

    calculate = function (slot)
      return 0 - (slot.quantity * slot.item.sell_value)
    end
  }
}


local function compare_slots(a, b)
  local slot_a = a.data
  local slot_b = b.data

  for _, handler in ipairs(score_handlers) do
    --
    -- Run the test condition on both slots. If a slot matches the rule,
    -- calculate its priority score; otherwise, leave it as nil.

    local score_a = nil
    if handler.test(slot_a) then
      score_a = handler.calculate(slot_a)
    end

    local score_b = nil
    if handler.test(slot_b) then
      score_b = handler.calculate(slot_b)
    end

    -- If at least one slot was evaluated by the current rule:

    if score_a ~= nil or score_b ~= nil then
      --
      -- Assign a penalizing default score to an item if it failed
      -- the rule test while the other item succeeded.

      score_a = score_a or score_b + 1
      score_b = score_b or score_a + 1

      -- If this rule establishes a clear winner (different scores),
      -- sort the item with the lower score to the front.

      if score_a ~= score_b then
        return score_a < score_b
      end
    end
  end

  -- If both items tie across all rules, sort alphabetically by name.

  return (slot_a and slot_b) and (
    (slot_a.name or "unknown") < (slot_b.name or "unknown")
  )
end


LootFrame:UnregisterEvent("LOOT_OPENED")



context.add_event_hook(
  "LOOT_PROCESSED", function(slots)
    local provider = CreateDataProvider()

    for _, slot in ipairs(slots) do
      if not slot.autolooted then
        local quality = (
          type(slot.item) == "table" and slot.item.quality
          )
          or Enum.ItemQuality.Common
        
        provider:Insert({
          data = slot,
          slotIndex = slot.index,
          quality = quality
        })
      end
    end
    
    if not provider:IsEmpty() then
      LootFrame:Open()
      
      if not UnitAffectingCombat("player") then
        provider:SetSortComparator(compare_slots)
        LootFrame.ScrollBox:SetDataProvider(provider)
      end
    end
  end
)
