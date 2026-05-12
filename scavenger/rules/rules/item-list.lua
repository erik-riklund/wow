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
-- # Item exception rule processing
--
-- Compares active item slots against the hardcoded blacklist/whitelist configuration
-- array located in 'settings.items'. If an exact item link match is found, the rule
-- processes the entry's custom behaviors.
--
-- Supports two evaluation methods:
-- 1. Direct action: Matches explicit string choices (e.g., "ignore" returns false).
-- 2. Quantity bounding: Returns a boolean indicating if the slot's current stack size
--    falls within the configured minimum and maximum limits.
--

scavenger.register_loot_rule(
  function(slot)
    if slot.type == Enum.LootSlotType.Item then
      local item = slot.item

      -- Check if the item matches any entries in the explicit exceptions registry.

      local rule = nil
      for _, current_rule in ipairs(settings.items) do
        local _, link = C_Item.GetItemInfo(current_rule.id)
        if link == item.link then
          rule = current_rule
          break
        end
      end

      -- If a matching configuration exception exists, process its parameters.

      if rule ~= nil then
        -- Handle explicit string actions.
        if type(rule.action) == "string" then
          return rule.action ~= "ignore" -- Returns false if the item should be ignored.
        end

        -- Handle stack size constraint boundaries.
        if type(rule.quantity) == "table" then
          if type(rule.quantity.min) == "number" or type(rule.quantity.max) == "number" then
            return (not rule.quantity.min or slot.quantity >= rule.quantity.min)
                and (not rule.quantity.max or slot.quantity <= rule.quantity.max)
          end
        end
      end
    end
  end
)
