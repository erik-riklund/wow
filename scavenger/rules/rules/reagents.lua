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
-- # Crafting reagent rule processing
--
-- Evaluates items belonging to the tradeskill category against the profile definitions
-- located in 'settings.reagents'. It scans for a matching subclass ID configuration
-- entry (e.g., Herbs, Cloth, Leather) to determine handling rules.
--
-- The rule determines item eligibility by applying specific filters:
-- 1. Quality threshold: Compares item quality against the target profile's specific
--    override value, falling back to the global profile baseline if an override is absent.
-- 2. Optional quantity bounds: Validates the current slot stack size against minimum or
--    maximum constraints if a quantity restriction table is active for that reagent type.
--

scavenger.register_loot_rule(
  function(slot)
    if slot.type == Enum.LootSlotType.Item then
      local item = slot.item

      if item.type_id == Enum.ItemClass.Tradegoods then
        local rule = nil

        -- Search for a specific rule matching the reagent's trade good subclass ID.

        for _, current_rule in ipairs(settings.reagents.lootable_types) do
          if current_rule.id == item.subtype_id then
            rule = current_rule
            break
          end
        end

        -- If a matching reagent profile exists, evaluate quality and quantity rules.

        if rule ~= nil then
          local quality_threshold = settings.reagents.quality_threshold

          -- Prioritize the rule-specific override value over the global configuration fallback.
          if rule.quality_threshold ~= nil then
            quality_threshold = rule.quality_threshold
          end

          -- Reject looting if the item exceeds the determined quality threshold limit.
          if item.quality > quality_threshold then return false end

          -- Bypass stack size evaluations and loot automatically if quantity rules are omitted.
          if type(rule.quantity) ~= "table" then return true end

          -- Enforce stack size boundary constraints when min or max parameters are defined.
          if type(rule.quantity.min) == "number" or type(rule.quantity.max) == "number" then
            return (rule.quantity.min == nil or slot.quantity >= rule.quantity.min)
                and (rule.quantity.max == nil or slot.quantity <= rule.quantity.max)
          end
        end
      end
    end
  end
)
