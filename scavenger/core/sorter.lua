--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
--   github.com/erik-riklund/wow/scavenger/core (2026)

---@class context
local x = select(2, ...)

--
-- # Slot type priority
--
-- Defines the primary sorting order of loot based on its core category.
--

local slot_type_order = {
  Enum.LootSlotType.Money,
  Enum.LootSlotType.Currency,
  Enum.LootSlotType.Item
}

--
-- # Item category priority
--
-- Sub-sorting rules applied specifically to item slots.
--

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

--
-- # Sorting criteria chain
--
-- An ordered list of evaluation rules. When comparing two items, the engine
-- runs through these rules from top to bottom. The first rule where the items
-- yield different scores decides their placement (lowest score goes first).
--

local score_handlers = {
  --
  -- Rule 1: Quest items
  --
  -- Prioritizes quest items by giving them the absolute lowest possible
  -- baseline score (0), pushing them straight to the top of the window.
  --

  {
    test = function(slot)
      return slot.is_quest_item
    end,

    calculate = function(slot) return 0 end
  },

  --
  -- Rule 2: Slot type
  --
  -- Applies the slot category hierarchy defined in 'slot_type_order'.
  --

  {
    test = function(slot)
      return true -- Runs on every slot to establish the primary category sort.
    end,

    calculate = function(slot)
      for position, slot_type in ipairs(slot_type_order) do
        if slot_type == slot.type then return position end
      end

      return #slot_type_order + 1 -- Fallback for unrecognized categories (placed last).
    end
  },

  --
  -- Rule 3: Item quality
  --
  -- Prioritizes high-rarity items over low-rarity items.
  -- Subtracting quality from 8 inverts WoW's quality values (Poor = 0, Legendary = 5)
  -- so that better items yield a lower score (e.g., Legendary = 3, Poor = 8).
  --

  {
    test = function(slot)
      return slot.item ~= nil and slot.type == Enum.LootSlotType.Item
    end,

    calculate = function(slot)
      return 8 - slot.item["quality"]
    end
  },

  --
  -- Rule 4: Sub-category priority
  --
  -- Arranges item subclasses matching the 'item_type_order' hierarchy.
  --

  {
    test = function(slot)
      return slot.item ~= nil and slot.type == Enum.LootSlotType.Item
    end,

    calculate = function(slot)
      for position, entry in ipairs(item_type_order) do
        local type_id, subtype_id = unpack(entry)
        if type_id == slot.item["type_id"] then
          if subtype_id == nil or subtype_id == slot.item["subtype_id"] then
            return position -- Returns matching position (lower position = higher priority).
          end
        end
      end

      return #item_type_order + 1 -- Fallback for unlisted categories (placed last).
    end
  },

  --
  -- Rule 5: Equipment item level
  --
  -- Sorts non-poor armor and weapons by item level. We subtract the item level from 5000
  -- to invert the values (higher item level yields a lower score).
  --

  {
    test = function(slot)
      if slot.type == Enum.LootSlotType.Item then
        return slot.item ~= nil and slot.item["quality"] > Enum.ItemQuality.Poor and (
          slot.item["type_id"] == Enum.ItemClass.Armor or slot.item["type_id"] == Enum.ItemClass.Weapon
        )
      end
    end,

    calculate = function(slot)
      return 5000 - slot.item["actual_level"]
    end
  },

  --
  -- Rule 6: Poor quality items vendor value
  --
  -- Sorts trash (junk) items by total vendor resale value.
  -- Multiplies quantity by sell value and subtracts it from 0 to yield negative values
  -- to ensure that the most lucrative stack of junk gets the lowest score.
  --

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

--
-- # Slot comparison comparator
--
-- Shared sorting function exposed to the context table. It extracts the raw slot data
-- packets from two wrapper objects and runs them through the score evaluation chain.
-- Returns true if slot 'a' should be ordered before slot 'b'.
--

x.compare_slots = function(a, b)
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
