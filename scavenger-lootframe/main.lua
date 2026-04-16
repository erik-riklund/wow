--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger-lootframe (2026)

local target_frame = LootFrame;
-- target_frame:UnregisterAllEvents(); -- disable during development.

-------------------------------------------------------------------------------
-- # Frame layout constants
--
-- Configuration for the loot window dimensions and structural spacing.
-- Defines how the UI scales and offsets elements within the container.
--

local frame_width = 350;      -- Fixed width of the loot window.
local frame_base_height = 65; -- Starting height before adding item slots.
local frame_padding_top = 60; -- Offset from the top to account for title/header.
local pagination_height = 30; -- Reserved vertical space for page navigation.
local items_per_page = 5;     -- Maximum number of items displayed per view.

-------------------------------------------------------------------------------
-- # Button visual configuration
--
-- Defines the dimensions and interactive state styling for loot slot buttons.
-- Used to handle hover effects and visual feedback during mouseover.
--

local button_height = 60;                                -- Height of each individual loot slot button.
local button_spacing = 1;                                -- Vertical gap between loot buttons.
local button_idle_background_color = { 0, 0, 0, 0.2 };   -- Default background color (RGBA) when not hovered.
local button_hover_background_color = { 0, 0, 0, 0.35 }; -- Darkened background color (RGBA) on mouseover.
local button_icon_idle_alpha = 0.5;                      -- Transparency of the item icon in its default state.
local button_icon_hover_alpha = 0.85;                    -- Increased opacity for the icon on mouseover.

-------------------------------------------------------------------------------
-- # Loot frame initialization
--
-- Defines the core UI container using the standard portrait template.
-- Handles initial visibility, mouse interaction, and spatial anchoring.
--

local loot_frame = CreateFrame(
  "Frame", "ScavengerLootFrame", UIParent, "PortraitFrameTemplate"
);
loot_frame:SetPortraitToAsset("interface/icons/inv_misc_bag_12");

loot_frame:SetShown(false);
loot_frame:EnableMouse(true);
loot_frame:SetPoint("TOP", UIParent, "TOP", 0, -200); -- enabled during development.
-- loot_frame:SetPoint("TOP", target_frame, "TOP"); -- enabled for release.
loot_frame:SetWidth(frame_width);

-------------------------------------------------------------------------------
-- # ?
--
-- ...
--

-- # Loot button registry
--
-- Manages a pool of reusable button frames for the loot interface.
-- Implements a basic object pooling pattern to minimize frame creation overhead.
--

local button_pool = {
  -- Each button has an occupied state and the frame itself.
};

local function get_button()
  local button;
  for _, entry in ipairs(button_pool) do
    if not entry.occupied then
      entry.occupied = true;
      button = entry.frame;
      break;
    end
  end

  if not button then
    -- ?

    button = CreateFrame("Button", nil, loot_frame);
    table.insert(button_pool, { occupied = true, frame = button });

    button:SetSize(frame_width * 0.975, button_height);

    button.background = button:CreateTexture(nil, "BACKGROUND");
    button.background:SetColorTexture(unpack(button_idle_background_color));
    button.background:SetAllPoints();

    button.icon = button:CreateTexture(nil, "BACKGROUND");
    button.icon:SetAlpha(button_icon_idle_alpha);
    button.icon:SetPoint("LEFT", button, "LEFT", frame_width * 0.025, 0);
    button.icon:SetSize(button_height * 0.75, button_height * 0.75);

    button.text = {
      name = button:CreateFontString(nil, "OVERLAY", "Number13Font"),
      description = button:CreateFontString(nil, "OVERLAY", "Number12Font"),
      icon_overlay = button:CreateFontString(nil, "OVERLAY", "Game12Font_o1")
    };

    button.text["name"]:SetAlpha(0.8);
    button.text["name"]:SetPoint(
      "TOPLEFT", button.icon, "TOPRIGHT", frame_width * 0.025, -(button_height * 0.05)
    );

    button.text["description"]:SetAlpha(0.7);
    button.text["description"]:SetPoint(
      "TOPLEFT", button.text["name"], "BOTTOMLEFT", 0, -(button_height * 0.05)
    );

    button.text["icon_overlay"]:SetAlpha(0.8);
    button.text["icon_overlay"]:SetPoint("BOTTOMRIGHT", button.icon, "BOTTOMRIGHT", -1, 3);

    -- ?

    button.on_event = {
      mouse_enter = function()
        if not button.is_disabled then
          button.icon:SetAlpha(button_icon_hover_alpha);
          button.background:SetColorTexture(unpack(button_hover_background_color));
        end
      end,
      mouse_leave = function()
        button.icon:SetAlpha(button_icon_idle_alpha);
        button.background:SetColorTexture(unpack(button_idle_background_color));
      end
    };

    -- ?

    button.meta = {};
  else
    -- ?

    button.text["name"]:SetText("");
    button.text["description"]:SetText("");
    button.text["icon_overlay"]:SetText("");
  end

  button:SetScript("OnEnter", button.on_event["mouse_enter"]);
  button:SetScript("OnLeave", button.on_event["mouse_leave"]);

  return button;
end

-------------------------------------------------------------------------------
-- # ?
--
-- ...
--

local handlers = {};
local decorators = {};

-- ?

function scavenger.register_slot_handler(handler)
  table.insert(handlers, handler);
end

-- ?

function scavenger.register_slot_decorator(decorator)
  table.insert(decorators, decorator);
end

-------------------------------------------------------------------------------
-- # ?
--
-- ...
--

function render_loot_frame(slots)
  local remaining_slots = {};
  for _, slot in ipairs(slots) do
    if not slot.autolooted then
      table.insert(remaining_slots, slot);
    end
  end

  if #remaining_slots > 0 then
    local buttons = {};
    local button_count = 0;

    -- todo > sort the slots based on quality and type.

    for _, slot in ipairs(remaining_slots) do
      local button = get_button();
      table.insert(buttons, button);

      -- ?

      button.icon:SetTexture(slot.icon);
      button.text["name"]:SetText(
        (#slot.name > 40 and (string.sub(slot.name, 1, 40) .. "...") or slot.name)
      );

      -- ?

      local responsible_handler;
      for _, handler in ipairs(handlers) do
        if handler.test(slot) then
          responsible_handler = handler.run;
        end
      end

      if not responsible_handler then
        responsible_handler = function(slot, button)
          button.text["description"]:SetText("Rendered using the fallback handler.");
        end
      end

      responsible_handler(slot, button);

      -- ?

      for _, decorator in ipairs(decorators) do decorator(slot, button) end

      -- ?

      local vertical_offset = frame_padding_top + (
        button_count * (button_height + button_spacing)
      );
      button:SetPoint("TOP", loot_frame, "TOP", 0, -vertical_offset);

      -- ?

      button_count = button_count + 1;
      if button_count == items_per_page then button_count = 0 end
    end

    -- ?

    local function render_buttons(page)
      local offset = items_per_page * ((page or 1) - 1);
      local initial_slot = offset + 1;
      local last_slot = math.min(#buttons, offset + items_per_page);

      for index, button in ipairs(buttons) do
        button:SetShown(index >= initial_slot and index <= last_slot);
      end
    end

    -- ?

    if #buttons > items_per_page then
      -- todo > implement pagination logic.
    end

    -- ?

    local has_pagination = #remaining_slots > items_per_page;
    local visible_item_count = has_pagination and items_per_page or #remaining_slots;
    local list_height = (visible_item_count * (button_height + button_spacing)) - button_spacing;

    loot_frame:SetHeight(
      frame_base_height + list_height + (has_pagination and pagination_height or 0)
    );

    -- ?

    render_buttons(1);
    loot_frame:SetShown(true);
  end
end
