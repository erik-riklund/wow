local _, config = ...

-- ?

function to_copper(amount)
  local gold = amount.gold or 0
  local silver = amount.silver or 0
  local copper = amount.copper or 0

  return copper + (silver * 100) + (gold * 10000)
end

-- ?

local maximum_amount = to_copper(config.money)

register_loot_rule({
  test = function(slot)
    return slot.type == Enum.LootSlotType.Money
  end,

  evaluate = function(slot)
    local segments = { string.split("\n", slot.name) }
    local money = { gold = 0, silver = 0, copper = 0 }

    for _, raw_value in ipairs(segments) do
      local amount, value = string.split(" ", raw_value)
      money[string.lower(value)] = tonumber(amount) or 0
    end

    return to_copper(money) <= maximum_amount
  end
})

-- ?

for index, rule in ipairs(config.rules) do register_loot_rule(rule) end
