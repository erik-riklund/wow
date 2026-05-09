--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger/ui (2026)

--- @class context
local x = select(2, ...)

--
-- # ?
--
-- ...
--

local function to_copper(amount)
  local gold = amount.gold or 0
  local silver = amount.silver or 0
  local copper = amount.copper or 0

  return copper + (silver * 100) + (gold * 10000)
end

--
-- # ?
--
-- ...
--

table.insert(
  x.slot_handlers, {
    --
    -- ?

    type = "money",

    -- ?

    test = function(slot)
      return slot.type == Enum.LootSlotType.Money
    end,

    -- ?

    create = function(button)
      -- todo > adjust the position of the displayed value.
    end,

    -- ?

    initialize = function(slot, button)
      ---@diagnostic disable-next-line: undefined-field
      local segments = { string.split("\n", slot.name) }
      local money = { gold = 0, silver = 0, copper = 0 }

      for _, raw_value in ipairs(segments) do
        ---@diagnostic disable-next-line: undefined-field
        local amount, value = string.split(" ", raw_value)
        money[string.lower(value)] = tonumber(amount) or 0
      end

      button.name_label:SetText(
        GetCoinTextureString(to_copper(money), 13)
      )
    end,

    -- ?

    reset = function(button) end
  }
)
