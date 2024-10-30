---@diagnostic disable: missing-return

---@class Scavenger
local context = select(2, ...)

--[[~ Module: Looter ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
local handlers = {
  ---@type LootHandler
  [Enum.LootSlotType.Item] = function(slotInfo)
    --
    -- ?

    ---@type CustomLootFilters
    local filters = context.config:getVariable 'filters'
    local itemInfo = backbone.getItemInfo(slotInfo.link)

    if not filters.ignore[itemInfo.id] then
      if filters.loot[itemInfo.id] then
        return true -- exists in the custom loot list.
      end

      if slotInfo.isQuestItem then
        --
        --

        ---@type QuestLootOptions
        local options = context.config:getVariable 'quest'
        return (options.lootAll or GetNumLootItems() == 1)
      else
        if itemInfo.quality == Enum.ItemQuality.Poor then
          --
          -- ?

          ---@type JunkLootOptions
          local options = context.config:getVariable 'junk'

          return (
            (IsFishingLoot() or itemInfo.sellPrice >= options.minimumValue) --
            and itemInfo.sellPrice <= options.maximumValue
          )
        else
          if itemInfo.itemTypeId == Enum.ItemClass.Tradegoods then
            --
            -- ?

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
            --
            -- ?

            if itemInfo.bindType == Enum.ItemBind.OnAcquire then
              ---@type GearLootOptions
              local options = context.config:getVariable 'gear'

              if options.isEnabled and UnitLevel 'player' >= options.requiredPlayerLevel then
                if
                  options.lootGearFromCurrentExpansion --
                  or (
                    not options.lootGearFromCurrentExpansion --
                    and itemInfo.expansionId < backbone.system.expansion
                  )
                then
                  return C_TransmogCollection.PlayerHasTransmogByItemInfo(itemInfo.link)
                end
              end
            end
          end
        end
      end
    end
  end,

  ---@type LootHandler
  [Enum.LootSlotType.Money] = function(slotInfo)
    --
    -- ?

    ---@type CurrencyLootOptions
    local options = context.config:getVariable 'currency'

    local cash = string.split('\n', slotInfo.name)
    local amount, value = string.split(' ', cash)
    return (value ~= 'Gold' or tonumber(amount) < options.lootableGoldThreshold)
  end,

  ---@type LootHandler
  [Enum.LootSlotType.Currency] = function(slotInfo)
    --
    -- ?

    ---@type CustomLootFilters
    local filters = context.config:getVariable 'filters'
    return not filters.ignore[slotInfo.currencyId]
  end,
}

---
--- ?
---
backbone.createChannel 'LOOT_PROCESSED'

---
--- ?
---
context.plugin:registerEventListener('LOOT_OPENED', {
  identifier = 'lootProcessor',
  ---@param isAutoloot boolean
  callback = function(isAutoloot)
    local remainingSlots = {}
    local lootCount = GetNumLootItems()

    for index = 1, lootCount do
      local slotInfo = backbone.getLootSlotInfo(index)

      if
        not slotInfo.isLocked --
        and slotInfo.slotType ~= Enum.LootSlotType.None
      then
        if not isAutoloot then
          local shouldBeLooted = handlers[slotInfo.slotType](slotInfo)

          if shouldBeLooted then
            LootSlot(index) -- the handler determined that the item should be looted.
          else
            ---@class LootableSlot
            local slot = { index = index, info = slotInfo }

            table.insert(remainingSlots, slot)
          end
        else
          LootSlot(index) -- when using standard autoloot.
        end
      end
    end

    backbone.invokeChannelListeners('LOOT_PROCESSED', { remainingSlots })
  end,
})
