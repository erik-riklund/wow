local _, config = ...

-- ?

config.money = { gold = 24, silver = 99, copper = 99 }

-- ?

config.rules =
{
  -- Specific currencies that SHOULD be looted:
  {
    test = function (slot)
      return slot.type == Enum.LootSlotType.Currency
    end,
    
    evaluate = function (slot)
      local currencies = {
        ["1155"] = true, -- Ancient Mana
      }
      
      if currencies[tostring(slot.currency_id)] then return true end
    end
  },

  -- Specific items that SHOULD be looted:
  {
    test = function (slot)
      return slot.type == Enum.LootSlotType.Item
    end,
    
    evaluate = function (slot)
      if type(slot.item) ~= "table" then return end
      
      local items =
      {
        -- Shadowlands
        
        ["186204"] = true, -- Anima-Stained Glass Shards
        ["187322"] = true, -- Crumbling Stone Tablet
        ["186200"] = true, -- Infused Dendrite
        ["184307"] = true, -- Maldraxxi Armor Scraps
        ["181642"] = true, -- Novice Principles of Plaguistry
        ["172092"] = true, -- Pallid Bone
        ["171840"] = true, -- Porous Stone
        ["186685"] = true, -- Relic Fragment
        ["186165"] = true, -- Residual Anima
        ["171841"] = true, -- Shaded Stone
        ["184306"] = true, -- Soulcatching Sludge
        ["187458"] = true, -- Unearthed Teleporter Sigil
        ["181643"] = true, -- Weeping Corpseshroom
      }
      
      if items[tostring(slot.item.id)] then return true end
    end
  },
  
  -- Always loot edible fish while fishing:
  {
    test = function (slot)
      return slot.is_fishing_loot and slot.type == Enum.LootSlotType.Item
    end,
    
    evaluate = function (slot)
      if type(slot.item) ~= "table" then return end
      
      if slot.item.type_id == Enum.ItemClass.Tradegoods
        and slot.item.subtype_id == 8 then return true
      end
    end
  }
}
