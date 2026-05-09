--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger/ui (2026)

--- @class context
local x = select(2, ...)

local frame_width = x.settings["frame_width"]
local slot_height = x.settings["slot_height"]
local slot_idle_background_color = x.settings["slot_idle_background_color"]
local slot_hover_background_color = x.settings["slot_hover_background_color"]
local slot_icon_idle_alpha = x.settings["slot_icon_idle_alpha"]
local slot_icon_hover_alpha = x.settings["slot_icon_hover_alpha"]

--
-- # Loot button registry
--
-- Manages a pool of reusable button frames for the loot interface.
-- Implements a basic object pooling pattern to minimize frame creation overhead.
--

local button_pool = {
  -- Each button has an occupied state, a type, and the frame itself.
}

--
-- # Base button creation
--
-- Generates a blank UI button frame with all the standard structural layers
-- (background, icon texture, and text labels) pre-positioned.
--
-- Specific behavior and unique styling are applied later by handlers.
--

local function create_base_button()
  local button = CreateFrame(
    "Button", nil, ScavengerLootFrame
  )

  button:SetShown(false)
  button:SetSize(frame_width * 0.975, slot_height)

  -- Solid color background block for the slot.
  -- Changes color during hover states.

  button.background = button:CreateTexture(nil, "BACKGROUND")
  button.background:SetColorTexture(unpack(slot_idle_background_color))
  button.background:SetAllPoints()

  -- Square item icon. Aligned to the far left of the slot,
  -- scaled to fit inside it nicely.

  button.icon = button:CreateTexture(nil, "BACKGROUND")

  button.icon:SetPoint("LEFT", button, "LEFT", frame_width * 0.025, 0)
  button.icon:SetSize(slot_height * 0.7, slot_height * 0.7)
  button.icon:SetAlpha(slot_icon_idle_alpha)

  -- Item name. Anchored directly to the top-right of the item icon.

  button.name_label =
      button:CreateFontString(nil, "OVERLAY", "Number13Font")

  button.name_label:SetPoint(
    "TOPLEFT", button.icon, "TOPRIGHT",
    frame_width * 0.025, -(slot_height * 0.05)
  )

  button.name_label:SetAlpha(0.9)

  -- Item description. Anchored directly beneath the item's name.

  button.description_label =
      button:CreateFontString(nil, "OVERLAY", "Number12Font")

  button.description_label:SetPoint(
    "TOPLEFT", button.name_label, "BOTTOMLEFT", 0, -(slot_height * 0.05)
  )

  button.description_label:SetAlpha(0.7)

  -- Extra information. Anchored directly beneath the description.

  button.note_label =
      button:CreateFontString(nil, "OVERLAY", "Number11Font")

  button.note_label:SetPoint(
    "TOPLEFT", button.description_label, "BOTTOMLEFT", 0, -(slot_height * 0.05)
  )

  button.note_label:SetAlpha(0.7)

  -- Icon overlay text. Typically used for displaying stack counts
  -- or item levels in the bottom-right corner of the icon.

  button.icon_label =
      button:CreateFontString(nil, "OVERLAY", "Game12Font_o1")

  button.icon_label:SetPoint(
    "BOTTOMRIGHT", button.icon, "BOTTOMRIGHT", -1, 3
  )
  button.icon_label:SetAlpha(0.8)

  -- Lock indicator. Placed in the top-right corner of the slot.

  button.lock_label =
      button:CreateFontString(nil, "OVERLAY", "Number11Font")

  button.lock_label:SetPoint(
    "TOPRIGHT", button, "TOPRIGHT",
    -(frame_width * 0.0125), -(slot_height * 0.05)
  )

  button.lock_label:SetText(LOCKED)
  button.lock_label:SetAlpha(0.8)

  -- Bind type indicator. Placed in the bottom-right corner of the slot.

  button.bind_type_label =
      button:CreateFontString(nil, "OVERLAY", "SystemFont_Small")

  button.bind_type_label:SetPoint(
    "BOTTOMRIGHT", button, "BOTTOMRIGHT", 0, slot_height * 0.05
  )
  button.bind_type_label:SetAlpha(0.7)

  return button
end

--
-- # Button recycling & retrieval
--
-- Grabs an unused button of the requested type from the pool.
-- If none are sitting idle, it generates a brand new frame on the fly,
-- initializes it using the provided handler, and stores it in the pool.
--

x.get_slot_button = function(handler)
  local button

  for _, entry in ipairs(button_pool) do
    if not entry.occupied and entry.type == handler.type then
      entry.occupied = true
      button = entry.frame

      break -- Exit early now that we found and claimed an available button.
    end
  end

  if not button then
    button = create_base_button()
    handler.create(button)

    table.insert(
      button_pool, {
        type = handler.type,
        frame = button,
        occupied = true
      }
    )
  end

  -- Enable the button to make sure it can handle click events.
  -- This is crucial if a previous use left the button disabled.

  button:SetEnabled(true)

  -- Trigger hover effects (brighter background and icon)
  -- when the player's mouse enters the slot area.

  button:SetScript(
    "OnEnter", function()
      if button:IsEnabled() then
        button.background:SetColorTexture(
          unpack(slot_hover_background_color)
        )
        button.icon:SetAlpha(slot_icon_hover_alpha)
      end
    end
  )

  -- Restore the button back to its dim, idle visual state
  -- once the player's mouse moves away.

  button:SetScript(
    "OnLeave", function()
      button.background:SetColorTexture(
        unpack(slot_idle_background_color)
      )
      button.icon:SetAlpha(slot_icon_idle_alpha)
    end
  )

  return button
end

--
-- # ?
--
-- ...
--

Scavenger.add_event_hook(
  "LOOT_CLOSED", function()
    for _, entry in ipairs(button_pool) do
      entry.frame:SetShown(false)
      entry.occupied = false
    end
  end
)
