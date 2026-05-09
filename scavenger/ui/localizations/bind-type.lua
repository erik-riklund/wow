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

x.localizations["bind_type"] = {
  [Enum.ItemBind.OnAcquire] = ITEM_BIND_ON_PICKUP,
  [Enum.ItemBind.OnEquip] = ITEM_BIND_ON_EQUIP,
  [Enum.ItemBind.OnUse] = ITEM_BIND_ON_USE,
  [Enum.ItemBind.Quest] = ITEM_BIND_QUEST,
  [Enum.ItemBind.ToWoWAccount] = ITEM_BIND_TO_ACCOUNT,
  [Enum.ItemBind.ToBnetAccount] = ITEM_BIND_TO_BNETACCOUNT,
  [Enum.ItemBind.ToBnetAccountUntilEquipped] = ITEM_BIND_TO_ACCOUNT_UNTIL_EQUIP
}
