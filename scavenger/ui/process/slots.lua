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
-- # UI processing step: Map loot slots to buttons
--
-- This step runs during the "LOOT_SORTED" pipeline. It loops through all sorted
-- loot slots, finds the matching handler type, grabs a recycled button from the
-- pool, and populates the button with the slot's specific item data.
--
-- The resulting buttons are stored in the shared 'context' table so that later
-- steps in the pipeline (like positioning or showing the frame) can access them.
--

table.insert(
  x.process, function(slots, context)
    context.slot_buttons = {}

    for _, slot in ipairs(slots) do
      local handler

      -- Loop through registered handlers to find one that knows how to
      -- deal with this specific slot type (e.g., a junk item vs. money).

      for _, current_handler in ipairs(x.slot_handlers) do
        if current_handler.test(slot) == true then
          handler = current_handler
          break -- Exit early as we found our matching handler.
        end
      end

      -- Ask the button pool for a button matching the handler's type.
      -- It will give us an existing, idle button or create a brand new one.

      local button = x.get_slot_button(handler)

      -- ?

      button.icon:SetTexture(slot.icon)
      button.lock_label:SetShown(slot.is_locked)

      -- ?

      button.name_label:SetText(
        ((slot.name and #slot.name > 40) and (string.sub(slot.name, 1, 40) .. "...")
          or (slot.name or "No name available (item not loaded)"))
      )

      if slot.item then
        local r, g, b = GetItemQualityColor(slot.item.quality)
        button.name_label:SetTextColor(r, g, b, 0.9)
      end

      -- ?

      if slot.quantity > 1 then
        button.icon_label:SetText(slot.quantity)
      end

      -- Let the matched handler take care of the rest of the button setup,
      -- such as populating labels and adjusting colors.

      handler.initialize(slot, button)

      -- ?

      button:SetScript(
        "OnClick", function(self, trigger, is_down)
          if trigger == "LeftButton" and not is_down then
            LootSlot(slot.index)
          end
        end
      )

      -- Add the configured button to our temporary list so that subsequent
      -- steps in the pipeline can easily layout or display them.

      table.insert(context.slot_buttons, { slot, button, handler })
    end
  end
)
