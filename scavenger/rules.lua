function to_copper (amount)
  local gold = amount.gold or 0
  local silver = amount.silver or 0
  local copper = amount.copper or 0

  return copper + (silver * 100) + (gold * 10000)
end

-- ?

table.insert(
  loot_rules,
  {
    test = function (slot)
      return slot.type == Enum.LootSlotType.Money
    end,

    evaluate = function (slot)
      local segments = { string.split("\n", slot.name) }
      local money = { gold = 0, silver = 0, copper = 0 }
      for _, raw_value in ipairs(segments) do
        local amount, value = string.split(" ", raw_value)
        money[string.lower(value)] = tonumber(amount) or 0
      end
      local maximum_amount = { gold = 24, silver = 99, copper = 99 }
      return to_copper(money) <= to_copper(maximum_amount)
    end
  }
)

-- ?

table.insert(
  loot_rules,
  {
    test = function (slot)
      return slot.is_fishing_loot
         and slot.type == Enum.LootSlotType.Item
         and type(slot.item) == "table"
    end,
    
    evaluate = function (slot)
      if slot.item.type_id == Enum.ItemClass.Tradegoods
        and slot.item.subtype_id == 8 then return true
      end
    end
  }
)

-- ?

local looted_quest_items = {}

table.insert(
  event_listeners.SLOT_LOOTED,
  
  function (slot)
    if type(slot.item) == "table" then
      if slot.is_quest_item and not slot.autolooted then
        looted_quest_items[tostring(slot.item.id)] = true
      end
    end
  end
)

table.insert(
  loot_rules,
  {
    test = function (slot)
      return slot.is_quest_item
         and type(slot.item) == "table"
    end,
    
    evaluate = function (slot)
      if slot.item.stack_count > 1 and looted_quest_items[tostring(slot.item.id)] then
        return true -- Loot quest items that have already been manually looted once.
      end
    end
  }
)

-- ?

local items =
{
  -- Shadowlands
  
  186204, -- Anima-Stained Glass Shards
  187322, -- Crumbling Stone Tablet
  186200, -- Infused Dendrite
  184307, -- Maldraxxi Armor Scraps
  181642, -- Novice Principles of Plaguistry
  172092, -- Pallid Bone
  171840, -- Porous Stone
  186685, -- Relic Fragment
  186165, -- Residual Anima
  171841, -- Shaded Stone
  184306, -- Soulcatching Sludge
  187458, -- Unearthed Teleporter Sigil
  181643, -- Weeping Corpseshroom
}

table.insert(
  loot_rules,
  {
    test = function (slot)
      return slot.type == Enum.LootSlotType.Item
         and type(slot.item) == "table"
    end,
    
    evaluate = function (slot)
      for _, item_id in ipairs(items) do
        if slot.item.id == item_id then return true end
      end
    end
  }
)
