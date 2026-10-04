--
--   github.com/erik-riklund/wow/scavenger

local _, context = ...

local current_loot = nil
LootFrame:SetPropagateKeyboardInput(true)

context.add_event_hook(
  "LOOT_PROCESSED", function(slots) current_loot = slots end
)

LootFrame:HookScript(
  "OnKeyDown", function(_, key)
    if current_loot ~= nil and key == "Z" then
      for _, slot in ipairs(current_loot) do
        if not slot.autolooted then LootSlot(slot.index) end
      end
    end
  end
)
