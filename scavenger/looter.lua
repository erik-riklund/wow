--
--   github.com/erik-riklund/wow/scavenger

local _, context = ...

local loot_controller =
{
  rules =
  {
    -- adds a default rule for all item slots to ensure that there is free bag space.
    {
      test = function(slot)
        return slot.type == Enum.LootSlotType.Item
      end,

      evaluate = function(slot)
        local free_slots = 0

        for bag_number = 0, 4 do
          if C_Container.GetContainerNumSlots(bag_number) > 0 then
            free_slots = free_slots + C_Container.GetContainerNumFreeSlots(bag_number)
          end
        end

        if free_slots == 0 then return false end
      end
    }
  }
}


function register_loot_rule(rule)
  if type(rule) ~= "table" then
    error("The rule must be a table with test and evaluate functions", 2)
  elseif type(rule.test) ~= "function" then
    error("Invalid rule: 'test' property must be a function", 2)
  elseif type(rule.evaluate) ~= "function" then
    error("Invalid rule: 'evaluate' property must be a function", 2)
  end

  table.insert(loot_controller.rules, rule)
end


context.add_event_hook(
  "LOOT_OPENED", function()
    local current_loot = {}
    local handled_slots = {}
    local slot_count = GetNumLootItems()

    if slot_count > 0 then
      for slot_index = 1, slot_count do
        local slot_type = GetLootSlotType(slot_index)

        if slot_type ~= Enum.LootSlotType.None then
          local slot_info = {
            GetLootSlotInfo(slot_index)
          }

          local icon = slot_info[1]
          local name = slot_info[2]
          local quantity = slot_info[3]
          local currency_id = slot_info[4]
          local is_locked = slot_info[6]
          local is_quest_item = slot_info[7]


          local slot_data = {
            type = slot_type,
            name = name,
            icon = icon,
            quantity = quantity,
            currency_id = currency_id,
            index = slot_index,

            is_locked = is_locked,
            is_quest_item = is_quest_item,
            is_fishing_loot = IsFishingLoot()
          }

          local item_link = GetLootSlotLink(slot_index)


          if item_link then
            local item_data = {
              C_Item.GetItemInfo(item_link)
            }
            
            local item_id = select(3, strfind(item_link, ":(%d+)"))

            slot_data.item = {
              id = item_id,
              link = item_data[2],
              quality = item_data[3],
              localized_type = item_data[6],
              localized_subtype = item_data[7],
              stack_count = item_data[8],
              equip_location = item_data[9],
              sell_value = item_data[11],

              type_id = item_data[12],
              subtype_id = item_data[13],
              bind_type = item_data[14],
              expansion_id = item_data[15],

              expansion_name = _G["EXPANSION_NAME" .. (item_data[15] or "")],
              actual_level = C_Item.GetDetailedItemLevelInfo(item_link),
              is_collected = C_TransmogCollection.PlayerHasTransmogByItemInfo(item_link)
            }
          end


          local decision = nil
          if not is_locked then
            for _, rule in ipairs(loot_controller.rules) do
              if rule.test(slot_data) then
                local result = rule.evaluate(slot_data)

                if type(result) == "boolean" then
                  decision = result
                  break -- exit early as soon as a rule takes ownership of the slot.
                end
              end
            end
          end

          slot_data.autolooted = decision == true
          slot_data.ignored = decision == false
          current_loot[slot_index] = slot_data

          if decision == true then LootSlot(slot_index) end
        end
      end


      context.invoke_listeners("LOOT_PROCESSED", current_loot)
    end


    local remove_closed
    local remove_cleared

    remove_closed = context.add_event_hook(
      "LOOT_CLOSED", function()
        handled_slots = {}
        remove_cleared()
        remove_closed()
      end
    )

    remove_cleared = context.add_event_hook(
      "LOOT_SLOT_CLEARED", function(index)
        local stringified_index = tostring(index)

        if not handled_slots[stringified_index] then
          if current_loot then
            context.invoke_listeners("SLOT_LOOTED", current_loot[index])
          end
          handled_slots[stringified_index] = true
        end
      end
    )
  end
)
