---@class Scavenger
local context = select(2, ...)

--[[~ Loot handler (module) ~
  Updated: 2024/11/20 | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
--- 
---@type table<LOOT_SLOT_TYPE, LootHandler>
---
local handlers =
{
  ---@type LootHandler
  [E_LOOT_SLOT_TYPE.ITEM] = function(slotInfo)
    --
    -- Items are looted if not included on the ignore list, if included
    -- in the custom loot list, or based on the specific rules below.

    ---@type LootFilters
    local filters = context.plugin:getSetting 'FILTERS'
    local itemInfo = backbone.getItemInfo(slotInfo.link)

    if not filters.IGNORE[itemInfo.id] then
      if filters.LOOT[itemInfo.id] then return true end -- exists in the custom loot list.

      if slotInfo.isQuestItem then
        --
        -- Quest items are looted if `lootAll` is enabled, or if it's the only item that dropped.

        ---@type QuestLootOptions
        local options = context.plugin:getSetting 'QUEST'
        return (options.LOOT_ALL or GetNumLootItems() == 1)
      else
        if itemInfo.quality == E_ITEM_QUALITY.POOR then
          --
          -- Poor quality items are looted if they are within the specified minimum and maximum value range.
          -- If the loot comes from fishing, only the maximum value is taken into account.

          ---@type JunkLootOptions
          local options = context.plugin:getSetting 'JUNK'

          return (
            itemInfo.sellPrice >= options.MINIMUM_VALUE and
              itemInfo.sellPrice <= options.MAXIMUM_VALUE
          )
        else
          if itemInfo.itemTypeId == E_ITEM_CLASS.TRADEGOODS then
            --
            -- Tradeskill items are looted if their subtype is listed as lootable,
            -- and the item quality is below the set quality cap.

            ---@type TradeskillLootOptions
            local options = context.plugin:getSetting 'TRADESKILL'

            return (
              options.LOOTABLE_SUBTYPES[itemInfo.itemSubTypeId] and
                itemInfo.quality < options.QUALITY_CAP
            )
          --
          elseif itemInfo.itemTypeId == E_ITEM_CLASS.ARMOR or
              itemInfo.itemTypeId == E_ITEM_CLASS.WEAPON then
            if itemInfo.bindType == E_ITEM_BIND.ON_ACQUIRE then
              --
              -- Soulbound armor and weapons are looted based on a number of variables.
              --
              -- * Gear from the current expansion is only looted if explicitly enabled (default: disabled).
              -- * When `lootOnlyKnownApperances` is enabled, the item's appearance must be known.

              ---@type GearLootOptions
              local options = context.plugin:getSetting 'GEAR'

              if options.ENABLED and UnitLevel 'player' >= options.PLAYER_LEVEL then
                if options.CURRENT_EXPANSION or itemInfo.expansionId < backbone.currentExpansion then
                  return (
                    not options.ONLY_KNOWN or C_TransmogCollection.PlayerHasTransmogByItemInfo(itemInfo.link)
                  )
                end
              end
            end
          end
        end
      end
    end

    return false -- the item did not match any of the required criteria and should not be looted.
  end,

  ---@type LootHandler
  [E_LOOT_SLOT_TYPE.MONEY] = function(slotInfo)
    --
    -- If enabled, coins are looted when the value is below the set threshold.

    ---@type CurrencyLootOptions
    local options = context.plugin:getSetting 'CURRENCY'

    if not options.LOOT_COINS then return false end

    local cash = strsplit('\n', slotInfo.name)
    local amount, value = strsplit(' ', cash)

    return (value ~= 'Gold' or tonumber(amount) < options.GOLD_THRESHOLD)
  end,

  ---@type LootHandler
  [E_LOOT_SLOT_TYPE.CURRENCY] = function(slotInfo)
    --
    -- Currencies are looted if enabled and not listed in the ignore list.

    ---@type CurrencyLootOptions
    local options = context.plugin:getSetting 'CURRENCY'

    if not options.LOOT_CURRENCIES then return false end

    ---@type LootFilters
    local filters = context.plugin:getSetting 'FILTERS'
    return not filters.IGNORE[slotInfo.currencyId]
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
      local remaining_slots = {}

      local item_count = GetNumLootItems()
      for index = 1, item_count do
        local slotInfo = backbone.getLootSlotInfo(index)
  
        if not slotInfo.isLocked and slotInfo.slotType ~= E_LOOT_SLOT_TYPE.NONE then
          local item_looted = false
  
          if not autoloot then
            if handlers[slotInfo.slotType](slotInfo) then
              LootSlot(index) -- the handler determined that the item should be looted.
              
              item_looted = true
            else
              ---@class LootableSlot
              local slot = { index = index, info = slotInfo }
              
              remaining_slots[#remaining_slots + 1] = slot
            end
          else
            LootSlot(index) -- when using standard autoloot.
            
            item_looted = true
          end
  
          if item_looted then
            -- backbone.invokeChannelListeners('SLOT_LOOTED', index, slotInfo)
          end
        end
      end
    end
  }
)
