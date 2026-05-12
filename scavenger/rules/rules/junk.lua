--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger/rules (2026)

--- @class context
local x = select(2, ...)
local settings = x.settings

--
-- # Poor quality item rule processing
--
-- Evaluates poor quality (grey) items against configured value thresholds. To prevent
-- inventory clutter from non-liquidable assets, soulbound single-unit items are excluded
-- from evaluation.
--
-- The item's total vendor sell value (unit price multiplied by stack quantity) is
-- converted to copper and checked against the boundaries defined in 'settings.junk'.
-- Items harvested via fishing bypass the minimum price constraint entirely.
--

scavenger.register_loot_rule(
  function(slot)
    if slot.type == Enum.LootSlotType.Item then
      local item = slot.item;

      if item.quality == Enum.ItemQuality.Poor then
        -- Skip soulbound items unless they stack,
        -- ensuring the item is vendorable or stackable.

        if item.bind_type == Enum.ItemBind.None or item.stack_count > 1 then
          local total_value = item.sell_value * slot.quantity

          -- Enforce value thresholds. Fishing items ignore the baseline minimum value.

          local is_lootable = (
            slot.is_fishing_loot or total_value >= x.to_copper(settings.junk.min_value)
          ) and total_value <= x.to_copper(settings.junk.max_value)

          if is_lootable then return true end
        end
      end
    end
  end
)
