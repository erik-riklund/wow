--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger/ui (2026)

--- @class context
local x = select(2, ...)

x.settings = {
  --
  -- # Frame layout constants
  --
  -- Configuration for the loot frame dimensions and structural spacing.
  --

  frame_width = 400,      -- Fixed width of the loot window.
  frame_base_height = 65, -- Starting height before adding item slots.
  frame_padding_top = 60, -- Offset from the top to account for title/header.

  --
  -- # Button visual configuration
  --
  -- Defines the dimensions and interactive state styling for loot slot buttons.
  --

  slot_height = 65,                                -- Height of each individual loot slot button.
  slot_spacing = 1,                                -- Vertical gap between loot buttons.
  slot_idle_background_color = { 0, 0, 0, 0.2 },   -- Default background color (RGBA) when not hovered.
  slot_hover_background_color = { 0, 0, 0, 0.35 }, -- Darkened background color (RGBA) on mouseover.
  slot_icon_idle_alpha = 0.5,                      -- Transparency of the item icon in its default state.
  slot_icon_hover_alpha = 0.85,                    -- Increased opacity for the icon on mouseover.
}
