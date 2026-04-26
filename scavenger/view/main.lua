--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger/view (2026)

local _, this = ...

-- local target_frame = LootFrame
-- target_frame:UnregisterAllEvents()

---------------------------------------------------------------------
-- ...
--

local button_width = this.button_width
local button_height = this.button_height
local button_spacing = this.button_spacing
local active_slot_link_width = this.active_slot_link_width
local max_items_shown = this.max_items_shown

local idle_slot_background_color = this.idle_slot_background_color
local active_slot_background_color = this.active_slot_background_color
local hovered_slot_highlight_color = this.hovered_slot_highlight_color
local information_panel_background_color = this.information_panel_background_color

---------------------------------------------------------------------
-- ...
--

local loot_frame = CreateFrame("Frame", nil, UIParent)

loot_frame:SetShown(false)
loot_frame:EnableMouse(true)
loot_frame:SetPropagateKeyboardInput(true)
loot_frame:SetFrameStrata("HIGH")
loot_frame:SetAllPoints()

loot_frame.background = loot_frame:CreateTexture(nil, "BACKGROUND")
loot_frame.background:SetColorTexture(0, 0, 0, 0.4)
loot_frame.background:SetAllPoints()

---------------------------------------------------------------------
-- ...
--

local information_panel = CreateFrame("Frame", nil, loot_frame)
information_panel:SetPoint("CENTER", loot_frame, "CENTER", 125, 0)
information_panel:SetSize(450, 550)

information_panel.background = information_panel:CreateTexture(nil, "BACKGROUND")
information_panel.background:SetColorTexture(unpack(information_panel_background_color))
information_panel.background:SetAllPoints()

---------------------------------------------------------------------
-- ...
--

local active_slot_link = CreateFrame("Frame", nil, loot_frame)
active_slot_link:SetSize(active_slot_link_width, button_height)

active_slot_link.background = active_slot_link:CreateTexture(nil, "BACKGROUND")
active_slot_link.background:SetColorTexture(unpack(information_panel_background_color))
active_slot_link.background:SetAllPoints()

-- ?

local function set_active_slot_link(button)
  active_slot_link:SetPoint("TOPLEFT", button, "TOPRIGHT", 0, 0)
end

---------------------------------------------------------------------
-- ...
--

loot_frame:RegisterEvent("LOOT_CLOSED")
loot_frame:RegisterEvent("PLAYER_REGEN_DISABLED")

loot_frame:SetScript(
  "OnEvent", function(self, trigger)
    if self:IsShown() then
      if trigger == "LOOT_CLOSED" then
        self:SetShown(false)
      elseif trigger == "PLAYER_REGEN_DISABLED" then
        CloseLoot() -- ?
      end
    end
  end
)

---------------------------------------------------------------------
-- ...
--

local button_pool = {}

local function create_button()
  local button = CreateFrame("Button", nil, loot_frame)
  button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
  button:SetSize(button_width, button_height)

  -- ?

  button.background = button:CreateTexture(nil, "BACKGROUND")
  button.background:SetColorTexture(unpack(idle_slot_background_color))
  button.background:SetAllPoints()

  -- ?

  button.focus_overlay = button:CreateTexture(nil, "HIGHLIGHT")
  button.focus_overlay:SetColorTexture(unpack(hovered_slot_highlight_color))
  button.focus_overlay:SetAllPoints()

  -- ?

  button.icon = button:CreateTexture(nil, "OVERLAY")
  button.icon:SetPoint("LEFT", button, "LEFT", button_width * 0.035, 0)
  button.icon:SetSize(button_height * 0.65, button_height * 0.65)

  return button
end

local function get_button(handler)
  for _, entry in ipairs(button_pool) do
    if not entry.occupied and entry.type == handler.type then
      entry.occupied = true
      return entry.button -- ?
    end
  end

  local entry = {
    occupied = true,
    type = handler.type,
    button = create_button(),
    handler = handler
  }

  handler.create(entry.button)
  entry.button:SetShown(false)
  table.insert(button_pool, entry)

  return entry.button
end

---------------------------------------------------------------------
-- ...
--

this.slot_handlers = {}

scavenger.add_event_hook(
  "LOOT_PROCESSED", function(slots)
    local remaining_slots = {}

    -- ?

    for _, slot in ipairs(slots) do
      if not slot.autolooted then
        local selected_handler
        for _, handler in ipairs(this.slot_handlers) do
          if handler.test(slot) == true then
            selected_handler = handler
            break
          end
        end

        local button = get_button(selected_handler)

        button:SetEnabled(true)
        button.icon:SetTexture(slot.icon)

        -- button:SetScript(
        --   "OnClick", function(self, trigger)
        --     if trigger == "LeftButton" then
        --       set_active_slot_link(button)
        --     else
        --       LootSlot(slot.index)
        --     end
        --   end
        -- )

        local destroy_listener
        destroy_listener = scavenger.add_event_hook(
          "SLOT_LOOTED", function(looted_slot)
            if looted_slot.index == slot.index then
              -- todo > clear the information panel.
              --      | set the visual state of the button to "disabled".
 
              button:SetEnabled(false)
              destroy_listener()
            end
          end
        )

        selected_handler.setup(slot, button)
        table.insert(remaining_slots, { slot, selected_handler, button })
      end
    end

    -- ?

    table.sort(remaining_slots, this.sort)

    -- ?

    loot_frame:SetScript(
      "OnKeyUp", function(self, key)
        if key == "ESCAPE" and self:IsShown() then
          self:SetShown(false)
        end
      end
    )

    -- ?

    loot_frame:SetScript(
      "OnShow", function(self)
        local buttons = {}
        local button_count = 0
        local anchor = information_panel

        for index, entry in ipairs(remaining_slots) do
          button_count = button_count + 1
          local slot, handler, button = unpack(entry)

          local anchor_point = button_count == 1 and "TOPLEFT" or "BOTTOMRIGHT"
          local margin_right = index == 1 and -active_slot_link_width or 0
          local margin_bottom = index > 1 and -button_spacing or 0

          button:SetPoint("TOPRIGHT", anchor, anchor_point, margin_right, margin_bottom)

          if button_count == max_items_shown then
            button_count = 0
            anchor = information_panel
          else
            anchor = button -- ?
          end

          button:SetScript(
            "OnClick", function(self, trigger)
              if trigger == "LeftButton" then
                this.set_active_slot(slot)
                set_active_slot_link(button)

                -- todo > set the visual state of the button to "active".
              else
                LootSlot(slot.index) -- ?
              end
            end
          )

          table.insert(buttons, button)

          if index == 1 then
            this.set_active_slot(slot)
            set_active_slot_link(buttons[1])
          end
        end

        local function render_buttons(page)
          local offset = max_items_shown * (page - 1)
          local starting_index = offset + 1
          for index, button in ipairs(buttons) do
            button:SetShown(
              button:IsEnabled() and index >= starting_index
              and index <= math.min(#buttons, offset + max_items_shown)
            )
          end
        end

        if #buttons > max_items_shown then
          -- todo > implement pagination.
        end

        render_buttons(1)
      end
    )

    -- ?

    loot_frame:SetScript(
      "OnHide", function(self)
        for _, entry in ipairs(button_pool) do
          if entry.occupied then
            entry.occupied = false
            entry.button:SetShown(false)
            entry.handler.reset(entry.button)
          end
        end

        -- CloseLoot()
      end
    )

    loot_frame:SetShown(true)
  end
)
