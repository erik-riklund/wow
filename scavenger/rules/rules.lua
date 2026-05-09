--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger-rules (2026)

local settings = ScavengerRules_Settings

local function to_copper(amount)
  local gold = amount.gold or 0
  local silver = amount.silver or 0
  local copper = amount.copper or 0

  return copper + (silver * 100) + (gold * 10000)
end

--
-- # Money
--
-- ...
--

Scavenger.register_loot_rule(function(slot)
  if slot.type == Enum.LootSlotType.Money then
    local segments = { string.split("\n", slot.name) }
    local money = { gold = 0, silver = 0, copper = 0 }

    for _, raw_value in ipairs(segments) do
      local amount, value = string.split(" ", raw_value)
      money[string.lower(value)] = tonumber(amount) or 0
    end

    local total_value = to_copper(money)

    return (
      settings.money.min_value == nil
      or total_value >= to_copper(settings.money.min_value)
    ) and (
      settings.money.max_value == nil
      or total_value <= to_copper(settings.money.max_value)
    )
  end
end)

--
-- # Currencies
--
-- ...
--

Scavenger.register_loot_rule(function(slot)
  -- ?
end)

--
-- # Items
--
-- ...
--

Scavenger.register_loot_rule(function(slot)
  if slot.type == Enum.LootSlotType.Item then
    local item = slot.item

    local rule = nil
    for _, current_rule in ipairs(settings.items) do
      local _, link = C_Item.GetItemInfo(current_rule.id)
      if link == item.link then
        rule = current_rule
        break
      end
    end

    if rule ~= nil then
      if type(rule.action) == "string" then
        return rule.action ~= "ignore" -- returns false if the item should be ignored.
      end

      if type(rule.quantity) == "table" then
        if type(rule.quantity.min) == "number" or type(rule.quantity.max) == "number" then
          return (rule.quantity.min == nil or slot.quantity >= rule.quantity.min)
              and (rule.quantity.max == nil or slot.quantity <= rule.quantity.max)
        end
      end
    end
  end
end)

--
-- # Quest items
--
-- ...
--

Scavenger.register_loot_rule(function(slot)
  if slot.type == Enum.LootSlotType.Item and slot.is_quest_item then
    return slot.item.stack_count > 1 -- loot non-unique quest items.
  end
end)

--
-- # Fishing
--
-- ...
--

Scavenger.register_loot_rule(function(slot)
  if slot.type == Enum.LootSlotType.Item and slot.is_fishing_loot then
    local item = slot.item
    local cooking_reagent = 8

    if item.type_id == Enum.ItemClass.Tradegoods and item.subtype_id == cooking_reagent then
      return true -- loot edible fish caught while fishing.
    end
  end
end)

--
-- # Reagents
--
-- ...
--

Scavenger.register_loot_rule(function(slot)
  if slot.type == Enum.LootSlotType.Item then
    local item = slot.item

    if item.type_id == Enum.ItemClass.Tradegoods then
      local rule = nil

      for _, current_rule in ipairs(settings.reagents.lootable_types) do
        if current_rule.id == item.subtype_id then
          rule = current_rule
          break
        end
      end

      if rule ~= nil then
        local quality_threshold = settings.reagents.quality_threshold

        if rule.quality_threshold ~= nil then
          quality_threshold = rule.quality_threshold
        end

        if item.quality > quality_threshold then
          return false -- ?
        end

        if type(rule.quantity) ~= "table" then
          return true -- ?
        end

        if type(rule.quantity.min) == "number" or type(rule.quantity.max) == "number" then
          return (rule.quantity.min == nil or slot.quantity >= rule.quantity.min)
              and (rule.quantity.max == nil or slot.quantity <= rule.quantity.max)
        end
      end
    end
  end
end)

--
-- # Junk
--
-- ...
--

Scavenger.register_loot_rule(function(slot)
  if slot.type == Enum.LootSlotType.Item then
    local item = slot.item;

    if item.quality == Enum.ItemQuality.Poor then
      if item.bind_type == Enum.ItemBind.None or item.stack_count > 1 then
        local total_value = item.sell_value * slot.quantity
        local is_lootable = (
          slot.is_fishing_loot or total_value >= to_copper(settings.junk.min_value)
        ) and total_value <= to_copper(settings.junk.max_value)

        if is_lootable then return true end
      end
    end
  end
end)
