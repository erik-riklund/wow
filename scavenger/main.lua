--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
--   github.com/erik-riklund/wow/scavenger (2026)

local _, this = ...;

-- // HELPER FUNCTIONS //

local to_copper = function(amount)
  local gold = amount.gold or 0;
  local silver = amount.silver or 0;
  local copper = amount.copper or 0;

  return copper + (silver * 100) + (gold * 10000);
end

-- // LOOT RULES //

local rules = {
  --
  -- ?
  --
  function(slot)
    if slot.type == Enum.LootSlotType.Item then
      local item = slot.item;

      local rule = nil;
      for _, current_rule in ipairs(this.items) do
        local _, link = C_Item.GetItemInfo(current_rule.id);
        if link == item.link then
          rule = current_rule;
          break;
        end
      end

      if rule ~= nil then
        -- print("Found a rule for " .. item.link); -- debug.
        if type(rule.action) == "string" then
          return rule.action ~= "ignore"; -- returns false if the item should be ignored.
        end

        if type(rule.quantity) == "table" then
          -- print("Using quantity rule for " .. item.link); -- debug.
          if type(rule.quantity.min) == "number" or type(rule.quantity.max) == "number" then
            return (rule.quantity.min == nil or slot.quantity >= rule.quantity.min)
                and (rule.quantity.max == nil or slot.quantity <= rule.quantity.max);
          end
        end
      end
    end
  end,

  --
  -- ?
  --
  function(slot)
    if slot.type == Enum.LootSlotType.Item then
      local item = slot.item;
      if item.quality == Enum.ItemQuality.Poor then
        if item.bind_type == Enum.ItemBind.None or item.stack_count > 1 then
          local total_value = item.sell_price * slot.quantity;
          return total_value >= to_copper(this.junk.min_value)
              and total_value <= to_copper(this.junk.max_value);
        end
      end
    end
  end,

  --
  -- ?
  --
  function(slot)
    if slot.type == Enum.LootSlotType.Item and slot.is_quest_item then
      return slot.item.stack_count > 1; -- loot non-unique quest items.
    end
  end,

  --
  -- ?
  --
  function(slot)
    if slot.type == Enum.LootSlotType.Item and slot.is_fishing_loot then
      -- ?
    end
  end,

  --
  -- ?
  --
  function(slot)
    if slot.type == Enum.LootSlotType.Item then
      local item = slot.item;
      if item.type_id == Enum.ItemClass.Tradegoods then
        local rule = nil;
        for _, current_rule in ipairs(this.reagents.lootable_types) do
          if current_rule.id == item.subtype_id then
            rule = current_rule;
            break;
          end
        end

        if rule ~= nil then
          local quality_threshold = this.reagents.quality_threshold;
          if rule.quality_threshold ~= nil then
            quality_threshold = rule.quality_threshold;
          end

          if item.quality > quality_threshold then
            return false; -- ?
          end
          if type(rule.quantity) ~= "table" then
            return true; -- ?
          end

          if type(rule.quantity.min) == "number" or type(rule.quantity.max) == "number" then
            return (rule.quantity.min == nil or slot.quantity >= rule.quantity.min)
                and (rule.quantity.max == nil or slot.quantity <= rule.quantity.max);
          end
        end
      end
    end
  end,

  --
  -- ?
  --
  function(slot)
    if slot.type == Enum.LootSlotType.Money then
      -- print("Money slot detected: " .. slot.name); -- debug trace.
      local segments = { string.split("\n", slot.name) };
      local money = { gold = 0, silver = 0, copper = 0 };

      for _, raw_value in ipairs(segments) do
        local amount, value = string.split(" ", raw_value);
        money[string.lower(value)] = tonumber(amount) or 0;
      end

      local total_value = to_copper(money);
      return (
        this.money.min_value == nil
        or total_value >= to_copper(this.money.min_value)
      ) and (
        this.money.max_value == nil
        or total_value <= to_copper(this.money.max_value)
      );
    end
  end
};

-- // CORE LOGIC //

local event_frame = CreateFrame("Frame");
event_frame:RegisterEvent("LOOT_OPENED");

event_frame:SetScript(
  "OnEvent", function(_, event_name, ...)
    if event_name == "LOOT_OPENED" then
      -- print("Event triggered: LOOT_OPENED"); -- debug trace.
      local slot_count = GetNumLootItems();
      local is_autoloot, is_from_item = ...;

      if slot_count > 0 then
        for slot_index = 1, slot_count do
          -- print("Processing slot: " .. slot_index); -- debug trace.
          local slot_type = GetLootSlotType(slot_index);
          local _, name, quantity, currency_id, _, is_locked, is_quest_item = GetLootSlotInfo(slot_index);

          if slot_type ~= Enum.LootSlotType.None and not is_locked then
            local slot_data = {
              type = slot_type,
              name = name,
              quantity = quantity,
              currency_id = currency_id,
              is_quest_item = is_quest_item,
              is_fishing_loot = IsFishingLoot()
            };
            local item_link = GetLootSlotLink(slot_index);

            if item_link then
              -- print("Handling item: " .. item_link); -- debug trace.
              local item_data = { C_Item.GetItemInfo(item_link) };

              -- DevTools_Dump(item_data); -- debug.

              slot_data.item = {
                link = item_data[2],
                quality = item_data[3],
                stack_count = item_data[8],
                sell_price = item_data[11],
                type_id = item_data[12],
                subtype_id = item_data[13],
                bind_type = item_data[14],
                expansion_id = item_data[15]
              };
            end

            -- DevTools_Dump(slot_data); -- debug.

            local decision = nil;
            for _, rule in ipairs(rules) do
              local result = rule(slot_data);
              if type(result) == "boolean" then
                decision = result;
                break; -- no further processing required.
              end
            end

            if decision == true then
              LootSlot(slot_index);
            end
          end
        end
      end
    end
  end
);
