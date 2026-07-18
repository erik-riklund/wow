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
-- # ?
--
-- ...
--

scavenger.register_loot_rule(
  {
    test = function(slot)
      return slot.type == Enum.LootSlotType.Currency
    end,

    evaluate = function(slot)
      local quantity = slot.quantity
      local currency_id = slot.currency_id

      local rule = nil
      for _, current_rule in ipairs(settings.currency) do
        if current_rule.id == currency_id then
          rule = current_rule
          break
        end
      end

      if rule ~= nil then
        if type(rule.quantity) ~= "table" then
          return true -- signal the controller to loot the slot.
        end

        if type(rule.quantity.min) == "number" or type(rule.quantity.max) == "number" then
          return (not rule.quantity.min or quantity >= rule.quantity.min)
              and (not rule.quantity.max or quantity <= rule.quantity.max)
        end
      end
    end
  }
)
