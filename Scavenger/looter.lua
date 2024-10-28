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
    ---@type CustomLootFilters
    local filters = context.config:getVariable 'FILTERS'
    local itemInfo = backbone.getItemInfo(slotInfo.link)

    if not filters.IGNORE[itemInfo.id] then
      if filters.LOOT[itemInfo.id] then
        return true -- exists in the custom loot list.
      end

      if slotInfo.isQuestItem then
        DevTools_Dump(slotInfo)
        print 'quest item handler: not implemented.' --
      else
        if itemInfo.quality == Enum.ItemQuality.Poor then
          ---@type JunkLootOptions
          local options = context.config:getVariable 'JUNK'

          return (
            itemInfo.sellPrice >= options.MIN_VALUE --
            and itemInfo.sellPrice <= options.MAX_VALUE
          )
        else
          if itemInfo.itemTypeId == Enum.ItemClass.Tradegoods then
            ---@type TradeskillLootOptions
            local options = context.config:getVariable 'TRADESKILL'

            return (
              options.SUBTYPES[itemInfo.itemSubTypeId] --
              and itemInfo.quality < options.QUALITY_CAP
            )
          --
          elseif
            itemInfo.itemTypeId == Enum.ItemClass.Armor --
            or itemInfo.itemTypeId == Enum.ItemClass.Weapon
          then
            if itemInfo.bindType == Enum.ItemBind.OnAcquire then
              ---@type GearLootOptions
              local options = context.config:getVariable 'GEAR'

              if options.ENABLED and UnitLevel 'player' >= options.PLAYER_LEVEL then
                if
                  options.CURRENT_EXPANSION --
                  or (not options.CURRENT_EXPANSION and itemInfo.expansionId < backbone.system.expansion)
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
    ---@type CurrencyLootOptions
    local options = context.config:getVariable 'CURRENCY'
    
    local cash = string.split('\n', slotInfo.name)
    local amount, value = string.split(' ', cash)
    
    return (value ~= 'Gold' or tonumber(amount) < options.GOLD_MAX)
  end,

  ---@type LootHandler
  [Enum.LootSlotType.Currency] = function(slotInfo)
    ---@type CustomLootFilters
    local filters = context.config:getVariable 'FILTERS'
    
    return not filters.IGNORE[slotInfo.currencyId]
  end,
}

---
--- ?
---
context.plugin:createChannel 'LOOT_PROCESSED'

---
--- ?
---
context.plugin:registerEventListener('LOOT_READY', {
  identifier = 'lootProcessor',
  ---@param isAutoloot boolean
  callback = function(isAutoloot)
    local lootCount = GetNumLootItems()

    local remainingSlots = {}
    for index = 1, lootCount do
      local slotInfo = backbone.getLootSlotInfo(index)
      if not slotInfo.isLocked and slotInfo.slotType ~= Enum.LootSlotType.None then
        if not isAutoloot then
          local shouldBeLooted = handlers[slotInfo.slotType](slotInfo)

          if shouldBeLooted then
            LootSlot(index) -- the item should be looted.
          else
            table.insert(remainingSlots, index)
          end
        else
          LootSlot(index) -- when using standard autoloot.
        end
      end
    end

    context.plugin:invokeChannelListeners('LOOT_PROCESSED', { remainingSlots })
  end,
})
