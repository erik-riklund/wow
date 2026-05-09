--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger/ui (2026)

--- @class context
local x = select(2, ...)

local overlay = ScavengerOverlay
local loot_frame = ScavengerLootFrame

local slot_height = x.settings["slot_height"]
local slot_spacing = x.settings["slot_spacing"]
local frame_padding_top = x.settings["frame_padding_top"]
local frame_base_height = x.settings["frame_base_height"]

--
-- # ?
--
-- ...
--

table.insert(
  x.process, function(slots, context)
    local looted_slots = {}

    -- ?

    local function set_frame_height(slot_count)
      local list_height = (slot_count * (slot_height + slot_spacing)) - slot_spacing
      loot_frame:SetHeight(frame_base_height + list_height)
    end

    -- ?

    local function render_slots()
      local slots_rendered = 0
      local offset_y = frame_padding_top

      for _, entry in ipairs(context.slot_buttons) do
        local slot, button = unpack(entry)

        -- ?

        button:SetShown(not looted_slots[tostring(slot.index)])

        -- ?

        if not looted_slots[tostring(slot.index)] then
          button:SetPoint("TOP", loot_frame, "TOP", 0, -offset_y)
          offset_y = offset_y + slot_height + slot_spacing

          slots_rendered = slots_rendered + 1
        end
      end

      return slots_rendered
    end

    -- ?

    set_frame_height(render_slots())

    -- ?

    loot_frame:SetShown(true)
    overlay:SetShown(true)

    -- ?

    local remove_slot_looted_listener = Scavenger.add_event_hook(
      "SLOT_LOOTED", function(looted_slot)
        looted_slots[tostring(looted_slot.index)] = true
        set_frame_height(render_slots())
      end
    )

    -- ?

    local remove_loot_closed_listener
    remove_loot_closed_listener = Scavenger.add_event_hook(
      "LOOT_CLOSED", function()
        remove_slot_looted_listener()
        remove_loot_closed_listener()
      end
    )
  end
)
