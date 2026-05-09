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

table.insert(
  x.slot_handlers, {
    --
    -- ?

    type = "junk",

    -- ?

    test = function(slot)
      if slot.type == Enum.LootSlotType.Item and slot.item then
        return slot.item.quality == Enum.ItemQuality.Poor
      end
    end,

    -- ?

    create = function(button)
      -- todo > set the note color (for uncollected transmogs)
    end,

    -- ?

    initialize = function(slot, button)
      local item = slot.item

      -- ?

      if item.bind_type ~= Enum.ItemBind.None then
        button.bind_type_label:SetText(
          x.localizations.bind_type[item.bind_type]
        )
      end

      -- ?

      if item.sell_value > 0 then
        button.description_label:SetText(
          GetCoinTextureString(item.sell_value, 12)
        )
      end

      -- ?

      if item.equip_location ~= "INVTYPE_NON_EQUIP_IGNORE" then
        x.bind_tooltip(slot, button)
      end
    end,

    -- ?

    reset = function(button)
      button.note_label:SetText("")
      button.bind_type_label:SetText("")
      button.description_label:SetText("")
    end
  }
)
