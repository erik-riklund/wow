--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger-lootframe (2026)

scavenger.register_slot_handler({
  test = function(slot)
    local item = slot.item;
    return slot.type == Enum.LootSlotType.Item
        and item and item.type_id == Enum.ItemClass.Weapon;
  end,
  run = function(slot, button)
    local item = slot.item;
    local r, g, b = GetItemQualityColor(item.quality);

    button.text["name"]:SetTextColor(r, g, b, 0.9);
    button.text["icon_overlay"]:SetTextColor(1, 0.82, 0);
    button.text["icon_overlay"]:SetText(item.actual_level);
    button.text["description"]:SetText(item.localized_subtype);

    -- todo > activate the "not collected" meta for uncollected items.
  end
});
