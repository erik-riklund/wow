---@diagnostic disable: undefined-field

--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger/rules (2026)

---@class context
local x = select(2, ...)
local settings = x.settings

--
-- # Raw money rule processing
--
-- Evaluates raw money drops by parsing the localized text string from the loot slot
-- into numeric gold, silver, and copper values.
--
-- The total parsed value is converted to copper and checked against the boundaries
-- defined in 'settings.money'. If the amount falls within the minimum and maximum
-- limits (or if a limit is omitted entirely), the rule returns true to trigger an
-- automatic loot action.
--

scavenger.register_loot_rule(
  {
    test = function(slot)
      return slot.type == Enum.LootSlotType.Money
    end,

    evaluate = function(slot)
      local segments = { string.split("\n", slot.name) }
      local money = { gold = 0, silver = 0, copper = 0 }

      -- Parse each line of the money text string (e.g., "14 Silver", "50 Copper").

      for _, raw_value in ipairs(segments) do
        local amount, value = string.split(" ", raw_value)
        money[string.lower(value)] = tonumber(amount) or 0
      end

      local total_value = x.to_copper(money)

      -- Enforce configuration value thresholds.

      return (
        settings.money.min_value == nil
        or total_value >= x.to_copper(settings.money.min_value)
      ) and (
        settings.money.max_value == nil
        or total_value <= x.to_copper(settings.money.max_value)
      )
    end

  }
)
