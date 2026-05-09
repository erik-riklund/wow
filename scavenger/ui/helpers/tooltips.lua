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

x.bind_tooltip = function(slot, button)
  --
  -- ?

  button:HookScript(
    "OnEnter", function()
      GameTooltip:SetOwner(button, "ANCHOR_TOP")
      GameTooltip:SetLootItem(slot.index)
    end
  )

  -- ?

  button:HookScript(
    "OnLeave", function()
      GameTooltip:SetShown(false)
    end
  )
end
