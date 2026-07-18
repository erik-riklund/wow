--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger/keybinds (2026)

local current_loot = nil
local target_frame = LootFrame

--
-- Register the current loot table.
--

scavenger.add_event_hook (
  "LOOT_PROCESSED", function (slots)
    current_loot = slots
  end
)

--
-- Listen for the LSHIFT key being pressed.
--

target_frame:HookScript(
  "OnKeyUp", function (_, key)
    if key == "LSHIFT" and current_loot ~= nil then
      for _, slot in ipairs(current_loot) do
        if not slot.autolooted then
          LootSlot(slot.index)
        end
      end
    end
  end
)
