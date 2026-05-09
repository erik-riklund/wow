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

--
-- # ?
--
-- ...
--

local loot_frame = CreateFrame(
  "Frame", "ScavengerLootFrame", ScavengerOverlay, "PortraitFrameTemplate"
)
loot_frame:SetPortraitToAsset("interface/icons/inv_misc_bag_12")

loot_frame:EnableMouse(true)
loot_frame:SetPoint("TOP", UIParent, "CENTER", 0, UIParent:GetHeight() * 0.5)
loot_frame:SetWidth(frame_width)

--
-- # ?
--
-- ...
--

loot_frame.CloseButton:HookScript(
  "OnClick", function() CloseLoot() end
)
