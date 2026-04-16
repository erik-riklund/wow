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
        and item and item.type_id == Enum.ItemClass.Tradegoods;
  end,
  run = function(slot, button)
    local item = slot.item;

    button.text["description"]:SetText(
      PROFESSIONS_MODIFIED_CRAFTING_REAGENT_BASIC
    );
    button.text["description"]:SetTextColor(0.5, 0.5, 1);

    if slot.quantity > 1 then
      button.text["icon_overlay"]:SetText(slot.quantity);
    end
  end
});
