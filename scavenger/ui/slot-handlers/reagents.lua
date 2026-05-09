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

    type = "reagent",

    -- ?

    test = function(slot)
      if slot.type == Enum.LootSlotType.Item and slot.item then
        return slot.item.type_id == Enum.ItemClass.Tradegoods
      end
    end,

    -- ?

    create = function(button)
      button.description_label:SetText(
        PROFESSIONS_MODIFIED_CRAFTING_REAGENT_BASIC
      )
      button.description_label:SetTextColor(0.40, 0.74, 0.99)
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

      if slot.quantity > 1 then
        button.icon_label:SetText(slot.quantity)
      end
    end,

    -- ?

    reset = function(button)
      button.icon_label:SetText("")
      button.bind_type_label:SetText("")
    end
  }
)
