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
  x.process, function(slots, context)
    local remove_listener
    remove_listener = Scavenger.add_event_hook(
      "LOOT_CLOSED", function()
        --
        -- ?

        for _, entry in ipairs(context.slot_buttons) do
          local slot, button, handler = unpack(entry)
          handler.reset(button)
        end

        remove_listener()
      end
    )
  end
)
