--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger/view (2026)

local _, this = ...

-------------------------------------------------------------------------------
-- ?
--

this.button_width = 300         -- ?
this.button_height = 60         -- ?
this.button_spacing = 1         -- ?
this.max_items_shown = 5        -- ?

this.active_slot_link_width = 5 -- ?

-------------------------------------------------------------------------------
-- ?
--

this.idle_slot_background_color = { 0.15, 0.15, 0.15, 0.75 }        -- ?
this.active_slot_background_color = { 0.15, 0.15, 0.15, 0.9 }       -- ?
this.hovered_slot_highlight_color = { 1, 1, 1, 0.05 }               -- ?
this.information_panel_background_color = { 0.15, 0.15, 0.15, 0.9 } -- ?

-------------------------------------------------------------------------------
-- ?
--

this.slot_type_order = {
  Enum.LootSlotType.Money,
  Enum.LootSlotType.Currency,
  Enum.LootSlotType.Item
}

-------------------------------------------------------------------------------
-- ?
--

this.item_type_order = {
  { Enum.ItemClass.Miscellaneous, Enum.ItemMiscellaneousSubclass.Mount },
  { Enum.ItemClass.Miscellaneous, Enum.ItemMiscellaneousSubclass.CompanionPet },
  { Enum.ItemClass.Weapon,        nil },
  { Enum.ItemClass.Armor,         nil },
  { Enum.ItemClass.Tradeskill,    nil }
}
