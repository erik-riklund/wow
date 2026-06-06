--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger/view (2026)

---@class context
local x = select(2, ...)

--
-- # Default UI interception
--
-- Disables the standard loot window initialization. Unregistering the core game
-- event stops the standard, unmodified layout from drawing on screen when a lootable
-- object is opened.
--

LootFrame:UnregisterEvent("LOOT_OPENED")

--
-- # Scrollbox data provider population
--
-- Listens for the post-auto-loot processing stage. It extracts any leftover
-- slots that weren't cleared by rules, wraps them in a standard UI data structure,
-- sorts them via the shared custom comparator, and binds them to the custom layout.
--

scavenger.add_event_hook(
  "LOOT_PROCESSED", function(slots)
    --
    -- Instantiate a fresh data engine collection to hold the layout objects.

    local provider = CreateDataProvider()

    for _, slot in ipairs(slots) do
      if not slot.autolooted then
        local quality = (type(slot.item) == "table" and slot.item.quality) or Enum.ItemQuality.Common
        provider:Insert({ slotIndex = slot.index, data = slot, quality = quality })
      end
    end

    -- If manual interaction is required for remaining items, render the frame.

    if not provider:IsEmpty() then
      --
      -- Sort the slots and populate the scrollbox.

      provider:SetSortComparator(x.compare_slots)
      LootFrame.ScrollBox:SetDataProvider(provider)

      -- Copied from the standard loot frame implementation.

      if GetCVarBool("lootUnderMouse") then
        if CanAutoSetGamePadCursorControl(true) then
          SetGamePadCursorControl(true)
        end

        LootFrame:Show()

        local cx, cy = GetCursorPosition()
        cx = cx / (LootFrame:GetEffectiveScale()) - 30
        cy = math.max((cy / LootFrame:GetEffectiveScale()) + 50, 350)

        LootFrame:ClearAllPoints()
        LootFrame:SetPoint("TOPLEFT", nil, "BOTTOMLEFT", cx, cy)
        LootFrame:Raise()
      else
        ShowUIPanel(LootFrame)
        LootFrame:ApplySystemAnchor()
      end

      local skipShow = true
      ScrollingFlatPanelMixin.Open(LootFrame, skipShow)
    end
  end
)
