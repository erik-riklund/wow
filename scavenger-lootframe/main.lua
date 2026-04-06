--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger-lootframe (2026)

local target_frame = LootFrame;
-- target_frame:UnregisterAllEvents();

--
-- # ?
--
-- ...
--

local frame_width = 350;
local frame_base_height = 65;
local frame_padding_top = 60;
local pagination_height = 30;
local items_per_page = 3;
local button_height = 50;
local button_spacing = 0;

--
-- # Loot frame initialization
--
-- ...
--

local loot_frame = CreateFrame(
  "Frame", "ScavengerLootFrame", UIParent, "PortraitFrameTemplate"
);
loot_frame:SetPortraitToAsset("interface/icons/inv_misc_bag_12");

loot_frame:SetShown(false);
loot_frame:EnableMouse(true);
loot_frame:SetPoint("CENTER", target_frame);
loot_frame:SetWidth(frame_width);

--
-- # ?
--
-- ...
--

local buttons = {};

local function get_loot_button()
  for _, button in ipairs(buttons) do
    if button.busy == false then
      button.busy = true;
      return button.frame;
    end
  end

  local button = CreateFrame("Frame", nil, loot_frame);
  table.insert(buttons, { busy = true, frame = button });

  button:SetWidth(frame_width - 6);
  button:SetHeight(button_height);

  button.background = button:CreateTexture(nil, "BACKGROUND");
  button.background:SetColorTexture(0, 0, 0, 0.3);
  button.background:SetAllPoints();

  return button;
end

local function reset_loot_button(button)
  button.busy = false;
  button.frame:ClearAllPoints();
  button.frame:SetShown(false);
end

--
-- # ?
--
-- ...
--

local function render_loot_buttons(slots, offset)
  local button_count = 0;
  local initial_slot = offset + 1;
  for index = initial_slot, math.min(#slots, offset + items_per_page) do
    local slot = slots[index];
    local button = get_loot_button();

    button:SetScript("OnEnter", function(self)
      if slot.data.item["link"] then
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
        GameTooltip:SetHyperlink(slot.data.item["link"]);
      end
    end);
    button:SetScript("OnLeave", function(self)
      GameTooltip:Hide();
    end);

    button:SetShown(true);
    button:SetPoint("TOP", loot_frame, "TOP", 0,
      -(frame_padding_top + (button_count * (button_height + button_spacing)))
    );
    button_count = button_count + 1;
  end
  return button_count;
end

local function render_loot_frame(slots, page)
  page = page or 1;
  local offset = items_per_page * (page - 1);
  local button_count = render_loot_buttons(slots, offset);

  -- ?

  loot_frame:SetHeight(
    frame_base_height +
    (#slots > items_per_page and pagination_height or 0) +
    (button_count * (button_height + button_spacing))
  );
  loot_frame:SetShown(true);
end

--
-- # ?
--
-- ...
--

scavenger.add_event_hook("LOOT_PROCESSED", function(slots)
  -- local remaining_slots = 0;
  -- for _, slot in ipairs(slots) do
  --   if not slot.autolooted then
  --     local button = get_loot_button();
  --     button:SetPoint("CENTER");
  --     button:SetShown(true);

  --     remaining_slots = remaining_slots + 1;
  --   end
  -- end
  -- loot_frame:SetHeight(
  --   frame_base_height + (button_height * math.min(remaining_slots, items_per_page))
  -- );
  -- loot_frame:SetShown(remaining_slots > 0);
end);

scavenger.add_event_hook("LOOT_CLOSED", function()
  loot_frame:SetShown(false);
  for _, button in ipairs(buttons) do
    reset_loot_button(button);
  end
end);

--
-- # Dummy loot
--
-- ...
--

local current_loot = {
  [1] = {
    index = 1,
    autolooted = false,
    ignored = false,
    data = {
      type = 1, -- Item
      name = "Peacebloom",
      quantity = 2,
      currency_id = nil,
      is_locked = false,
      is_quest_item = false,
      is_fishing_loot = false,
      item = {
        link = "|cffffffff|Hitem:2447::::::::60:::::|h[Peacebloom]|h|r",
        quality = 1,
        localized_type = "Consumable",
        localized_subtype = "Herb",
        stack_count = 20,
        sell_price = 10,
        type_id = 0,
        subtype_id = 9,
        bind_type = 0,
        expansion_id = 0
      }
    }
  },
  [2] = {
    index = 2,
    autolooted = false,
    ignored = true,
    data = {
      type = 1,
      name = "Broken Fang",
      quantity = 1,
      currency_id = nil,
      is_locked = false,
      is_quest_item = false,
      is_fishing_loot = false,
      item = {
        link = "|cffffffff|Hitem:1017::::::::60:::::|h[Broken Fang]|h|r",
        quality = 0,
        localized_type = "Miscellaneous",
        localized_subtype = "Junk",
        stack_count = 10,
        sell_price = 45,
        type_id = 15,
        subtype_id = 0,
        bind_type = 0,
        expansion_id = 0
      }
    }
  },
  [3] = {
    index = 3,
    autolooted = false,
    ignored = false,
    data = {
      type = 1,
      name = "Webbed Mantle",
      quantity = 1,
      currency_id = nil,
      is_locked = false,
      is_quest_item = false,
      is_fishing_loot = false,
      item = {
        link = "|cff1eff00|Hitem:4715::::::::60:::::|h[Webbed Mantle]|h|r",
        quality = 2,
        localized_type = "Armor",
        localized_subtype = "Cloth",
        stack_count = 1,
        sell_price = 850,
        type_id = 4,
        subtype_id = 1,
        bind_type = 2,
        expansion_id = 0
      }
    }
  },
  [4] = {
    index = 4,
    autolooted = false,
    ignored = false,
    data = {
      type = 2, -- Currency
      name = "Timeless Coin",
      quantity = 15,
      currency_id = 777,
      is_locked = true,
      is_quest_item = false,
      is_fishing_loot = false
      -- item table is nil because GetLootSlotLink returns nil for currency
    }
  },
  [5] = {
    index = 5,
    autolooted = false,
    ignored = false, -- decision remained nil (no rule matched)
    data = {
      type = 1,
      name = "Glowing Wax Lump",
      quantity = 1,
      currency_id = nil,
      is_locked = false,
      is_quest_item = true,
      is_fishing_loot = false,
      item = {
        link = "|cffffffff|Hitem:210714::::::::60:::::|h[Glowing Wax Lump]|h|r",
        quality = 1,
        localized_type = "Quest",
        localized_subtype = "Quest",
        stack_count = 100,
        sell_price = 0,
        type_id = 12,
        subtype_id = 0,
        bind_type = 1,
        expansion_id = 10
      }
    }
  }
}

render_loot_frame(current_loot);
