---@class Scavenger
local context = select(2, ...)

--[[~ Looter ~
  Updated: 2024/11/01 | Author(s): Erik Riklund (Gopher)
]]

---
--- Create the channel used to broadcast which slots that remain after
--- the autoloot process is finished.
---
backbone.createChannel 'LOOT_PROCESSED'

---
--- Create the channel used to broadcast information about the slot that was just looted.
---
backbone.createChannel 'SLOT_LOOTED'

---
--- The handler functions responsible for processing specific slot types.
---
local handlers = {
  ---@type LootHandler
  [Enum.LootSlotType.Item] = function(slotInfo)
    --
    -- Items are looted if not included on the ignore list, if included
    -- in the custom loot list, or based on the specific rules below.

    ---@type CustomLootFilters
    local filters = context.config:getVariable 'filters'
    local itemInfo = backbone.getItemInfo(slotInfo.link)

    if not filters.ignore[itemInfo.id] then
      if filters.loot[itemInfo.id] then
        return true -- exists in the custom loot list.
      end

      if slotInfo.isQuestItem then
        --
        -- Quest items are looted if `lootAll` is enabled, or if it's the only item that dropped.

        ---@type QuestLootOptions
        local options = context.config:getVariable 'quest'
        return (options.lootAll or GetNumLootItems() == 1)
      else
        if itemInfo.quality == Enum.ItemQuality.Poor then
          --
          -- Poor quality items are looted if they are within the specified minimum and maximum value range.
          -- If the loot comes from fishing, only the maximum value is taken into account.

          ---@type JunkLootOptions
          local options = context.config:getVariable 'junk'

          return (
            (IsFishingLoot() or itemInfo.sellPrice >= options.minimumValue) --
            and itemInfo.sellPrice <= options.maximumValue
          )
        else
          if itemInfo.itemTypeId == Enum.ItemClass.Tradegoods then
            --
            -- Tradeskill items are looted if their subtype is listed as lootable,
            -- and the item quality is below the set quality cap.

            ---@type TradeskillLootOptions
            local options = context.config:getVariable 'tradeskill'

            return (
              options.lootableSubtypes[itemInfo.itemSubTypeId] --
              and itemInfo.quality < options.qualityCap
            )
          --
          elseif
            itemInfo.itemTypeId == Enum.ItemClass.Armor --
            or itemInfo.itemTypeId == Enum.ItemClass.Weapon
          then
            if itemInfo.bindType == Enum.ItemBind.OnAcquire then
              --
              -- Soulbound armor and weapons are looted based on a number of variables.
              --
              -- * The player's level must be at or above the specified required level.
              -- * Gear from the current expansion is only looted if explicitly enabled (default: disabled).
              -- * When `lootOnlyKnownApperances` is enabled, the item's appearance must be known.

              ---@type GearLootOptions
              local options = context.config:getVariable 'gear'

              if options.isEnabled and UnitLevel 'player' >= options.requiredPlayerLevel then
                if
                  options.lootGearFromCurrentExpansion --
                  or itemInfo.expansionId < backbone.system.expansion
                then
                  return (
                    not options.lootOnlyKnownApperances --
                    or C_TransmogCollection.PlayerHasTransmogByItemInfo(itemInfo.link)
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
  [Enum.LootSlotType.Money] = function(slotInfo)
    --
    -- If enabled, coins are looted when the value is below the set threshold.

    ---@type CurrencyLootOptions
    local options = context.config:getVariable 'currency'

    if not options.lootCoins then return false end

    local cash = string.split('\n', slotInfo.name)
    local amount, value = string.split(' ', cash)

    return (value ~= 'Gold' or tonumber(amount) < options.lootableGoldThreshold)
  end,

  ---@type LootHandler
  [Enum.LootSlotType.Currency] = function(slotInfo)
    --
    -- Currencies are looted if enabled and not listed in the ignore list.

    ---@type CurrencyLootOptions
    local options = context.config:getVariable 'currency'

    if not options.lootCurrencies then return false end

    ---@type CustomLootFilters
    local filters = context.config:getVariable 'filters'
    return not filters.ignore[slotInfo.currencyId]
  end,
}

---
--- The event handler responsible for the actual loot process.
---
context.plugin:registerEventListener('LOOT_OPENED', {
  identifier = 'lootProcessor',
  ---@param isAutoloot boolean
  callback = function(isAutoloot)
    ---@type LootableSlot[]
    local remainingSlots = {}

    local lootCount = GetNumLootItems()
    for index = 1, lootCount do
      local slotInfo = backbone.getLootSlotInfo(index)

      if
        not slotInfo.isLocked --
        and slotInfo.slotType ~= Enum.LootSlotType.None
      then
        local itemLooted = false

        if not isAutoloot then
          if handlers[slotInfo.slotType](slotInfo) then
            LootSlot(index) -- the handler determined that the item should be looted.
            itemLooted = true
          else
            ---@class LootableSlot
            local slot = { index = index, info = slotInfo }
            remainingSlots[#remainingSlots + 1] = slot
          end
        else
          LootSlot(index) -- when using standard autoloot.
          itemLooted = true
        end

        if itemLooted then
          backbone.invokeChannelListeners('SLOT_LOOTED', index, slotInfo) --
        end
      end
    end

    backbone.invokeChannelListeners('LOOT_PROCESSED', remainingSlots)
  end,
})
