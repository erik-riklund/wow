---@class Scavenger
local context = select(2, ...)

--[[~ Loot handler (module) ~
  Updated: 2024/11/21 | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
---@type number
---
local item_count

---
--- ?
---
---@type number
---
local slots_cleared

---
--- ?
---
---@type Vector
---
local remaining_slots

---
--- Handlers responsible for processing different types of loot slots.
--- 
---@type table<LOOT_SLOT_TYPE, LootHandler>
---
local handlers =
{
  ---@type LootHandler
  [E_LOOT_SLOT_TYPE.ITEM] = function(slot_info)
    ---@type LootFilters
    local filters = context.plugin:getSetting 'FILTERS'
    local item_info = backbone.getItemInfo(slot_info.link)

    -- Items listed in the ignore filter should not be looted.

    if filters.IGNORE[item_info.id] then return false end

    -- Items listed in the custom loot filter will be looted.

    if filters.LOOT[item_info.id] then return true end

    -- Quest items are looted if `LOOT_ALL` is enabled, or if it's the only item that dropped.

    if slot_info.isQuestItem then
      ---@type QuestLootOptions
      local options = context.plugin:getSetting 'QUEST'

      return (options.LOOT_ALL or GetNumLootItems() == 1)
    end

    -- Poor quality items are looted if they are within the specified minimum and maximum value range.

    if item_info.quality == E_ITEM_QUALITY.POOR then
      ---@type JunkLootOptions
      local options = context.plugin:getSetting 'JUNK'

      return (item_info.sellPrice >= options.MINIMUM_VALUE and item_info.sellPrice <= options.MAXIMUM_VALUE)
    end

    -- Tradeskill items are looted if their subtype is listed as lootable
    -- and the item quality is below the set quality cap.

    if item_info.itemTypeId == E_ITEM_CLASS.TRADEGOODS then
      ---@type TradeskillLootOptions
      local options = context.plugin:getSetting 'TRADESKILL'

      return (options.LOOTABLE_SUBTYPES[item_info.itemSubTypeId] and item_info.quality < options.QUALITY_CAP)
    end

    -- Soulbound armor and weapons are looted based on a number of variables.
    --
    -- * The player's level must be at or above the specified required level (default: 60).
    -- * Gear from the current expansion is only looted if explicitly enabled (default: disabled).
    -- * When `ONLY_KNOWN` is enabled, the item's appearance must be known (default: enabled).

    if item_info.itemTypeId == E_ITEM_CLASS.ARMOR or item_info.itemTypeId == E_ITEM_CLASS.WEAPON then
      ---@type GearLootOptions
      local options = context.plugin:getSetting 'GEAR'

      if options.ENABLED and UnitLevel 'player' >= options.PLAYER_LEVEL then
        return (options.CURRENT_EXPANSION or item_info.expansionId < backbone.currentExpansion)
            and (not options.ONLY_KNOWN or C_TransmogCollection.PlayerHasTransmogByItemInfo(item_info.link))
      end
    end

    return false -- the item did not match any of the required criteria.
  end,

  ---@type LootHandler
  [E_LOOT_SLOT_TYPE.MONEY] = function(slot_info)
    --
    -- If enabled, coins are looted when the value is below the set threshold.

    ---@type CurrencyLootOptions
    local options = context.plugin:getSetting 'CURRENCY'

    if not options.LOOT_COINS then return false end

    local cash = strsplit('\n', slot_info.name)
    local amount, value = strsplit(' ', cash)

    return (value ~= 'Gold' or tonumber(amount) < options.GOLD_THRESHOLD)
  end,

  ---@type LootHandler
  [E_LOOT_SLOT_TYPE.CURRENCY] = function(slot_info)
    -- Currencies are looted if enabled and not listed in the ignore list.

    ---@type CurrencyLootOptions
    local options = context.plugin:getSetting 'CURRENCY'

    if not options.LOOT_CURRENCIES then return false end

    ---@type LootFilters
    local filters = context.plugin:getSetting 'FILTERS'
    return not filters.IGNORE[slot_info.currencyId]
  end
}

---
--- ?
---
context.plugin:registerEventListener(
  'LOOT_OPENED',
  {
    identifier = 'LOOT_OPENED',

    ---@param autoloot boolean
    callback = function (autoloot)
      slots_cleared = 0
      item_count = GetNumLootItems()

      remaining_slots = new 'Vector'

      for index = 1, item_count do
        local slot_info = backbone.getLootSlotInfo(index)
  
        if not slot_info.isLocked and slot_info.slotType ~= E_LOOT_SLOT_TYPE.NONE then
          if autoloot or (not autoloot and handlers[slot_info.slotType](slot_info)) then
            LootSlot(index) -- loot the current slot.
          else
            ---@class LootableSlot
            local slot = { index = index, info = slot_info }
              
            remaining_slots:insertElement(slot)
          end
        end
      end

      if remaining_slots:getSize() == item_count then
        context.plugin:invokeChannelListeners('LOOT_PROCESSED', remaining_slots)
      end
    end
  }
)

---
--- ?
---
context.plugin:registerEventListener(
  'LOOT_SLOT_CLEARED',
  {
    identifier = 'LOOT_SLOT_CLEARED',
    callback = function()
      slots_cleared = slots_cleared + 1

      local remaining_slots_count = remaining_slots:getSize()
      if remaining_slots_count > 0 and item_count - slots_cleared == remaining_slots_count then
        context.plugin:invokeChannelListeners('LOOT_PROCESSED', remaining_slots)
      end
    end
  }
)