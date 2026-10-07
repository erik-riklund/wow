-- Event handler:

_G.event_listeners =
{
  -- Game events:
  LOOT_OPENED = {},
  LOOT_CLOSED = {},
  LOOT_SLOT_CLEARED = {},
  
  -- Custom events:
  LOOT_PROCESSED = {},
  SLOT_LOOTED = {}
}

local event_frame = CreateFrame "Frame"
event_frame:RegisterEvent "LOOT_OPENED"
event_frame:RegisterEvent "LOOT_CLOSED"
event_frame:RegisterEvent "LOOT_SLOT_CLEARED"

local function invoke_listeners (event_name, ...)
  for index, callback in ipairs(event_listeners[event_name]) do
    local success, exception = pcall(callback, ...)
    if not success then
      print (string.format("%s [%d]: %s", event_name, index, exception))
    end
  end
end

event_frame:SetScript(
  "OnEvent", function (self, event_name, ...)
    invoke_listeners(event_name, ...)
  end
)

-- Loot controller:

_G.loot_rules = {}
local current_loot = {}
local handled_slots = {}

table.insert(
  event_listeners.LOOT_OPENED,
  
  function ()
    wipe(current_loot)
    wipe(handled_slots)
    
    local slot_count = GetNumLootItems()
    
    for index = 1, slot_count do
      local slot_type = GetLootSlotType(index)
      if slot_type ~= Enum.LootSlotType.None then
        local info = { GetLootSlotInfo(index) }
        local item_link = GetLootSlotLink(index)
        
        local data = {
          index = index,
          type = slot_type,
          name = info[2],
          icon = info[1],
          quantity = info[3],
          currency_id = info[4],

          is_locked = info[6],
          is_quest_item = info[7],
          is_fishing_loot = IsFishingLoot()
        }
        
        if item_link then
          local item_data = { C_Item.GetItemInfo(item_link) }
          local item_id = select(3, strfind(item_link, ":(%d+)"))
          
          data.item = {
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
          for _, rule in ipairs(loot_rules) do
            if rule.test(data) then
              local result = rule.evaluate(data)
              if type(result) == "boolean" then
                decision = result
                break -- exit as soon as a rule takes ownership of the slot.
              end
            end
          end
        end
        
        data.autolooted = decision == true
        data.ignored = decision == false
        
        current_loot[index] = data
        
        if decision == true then LootSlot(index) end
      end
    end
    
    invoke_listeners("LOOT_PROCESSED", current_loot)
  end
)

table.insert(
  event_listeners.LOOT_SLOT_CLEARED,
  
  function (index)
    local stringified_index = tostring(index)
    if not handled_slots[stringified_index] then
      handled_slots[stringified_index] = true
      invoke_listeners("SLOT_LOOTED", current_loot[index])
    end
  end
)
