--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger/ui (2026)

--
-- # Full-screen background overlay
--
-- Creates a dark, semi-transparent fullscreen backdrop when the loot window
-- is open. This helps isolate the loot UI visually and blocks background
-- mouse clicks so you don't accidentally click on the world or other units.
--

local overlay = CreateFrame(
  "Frame", "ScavengerOverlay", UIParent
)

overlay:SetAllPoints()
overlay:SetShown(false)
overlay:EnableMouse(true)
overlay:SetFrameStrata("HIGH")

overlay.background = overlay:CreateTexture(nil, "BACKGROUND")
overlay.background:SetColorTexture(0, 0, 0, 0.4)
overlay.background:SetAllPoints()

--
-- # Cleanup on close
--
-- Automatically hides the dark background overlay as soon as the loot window
-- is closed, whether that is via looting everything or closing it manually.
--

Scavenger.add_event_hook(
  "LOOT_CLOSED", function()
    overlay:SetShown(false)
  end
)
