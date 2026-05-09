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

    type = "fallback",

    -- ?

    test = function(slot)
      return true -- ?
    end,

    -- ?

    create = function(button)
      button.note_label:SetText(
        "Rendered using the fallback handler"
      )
    end,

    -- ?

    initialize = function(slot, button)
      if slot.item then
        button.description_label:SetText(slot.item.localized_subtype)
      end

      if slot.quantity > 1 then
        --
      end
    end,

    -- ?

    reset = function(button) end
  }
)
