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
        and item and item.quality == Enum.ItemQuality.Poor;
  end,
  run = function(slot, button)
    local item = slot.item;

    local r, g, b = GetItemQualityColor(item.quality);
    button.text["name"]:SetTextColor(r, g, b, 0.9);

    if slot.quantity > 1 then
      button.text["icon_overlay"]:SetText(slot.quantity);
    end

    if item.sell_price > 0 then
      button.text["description"]:SetText(
        GetCoinTextureString(item.sell_price * slot.quantity, 12)
      );
    end
  end
});
