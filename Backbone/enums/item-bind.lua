
--[[~ Updated: 2024/11/27 | Author(s): Gopher ]]

---@enum ITEM_BIND
---Represents the binding types for items in the game.
ENUM.ITEM_BIND = {
  ---The item has no binding.
        NONE = Enum.ItemBind.None,
  ---The item becomes soulbound when acquired.
  ON_ACQUIRE = Enum.ItemBind.OnAcquire,
  ---The item becomes soulbound when equipped.
    ON_EQUIP = Enum.ItemBind.OnEquip,
  ---The item becomes soulbound when used.
      ON_USE = Enum.ItemBind.OnUse,
  ---The item is bound to a specific quest.
       QUEST = Enum.ItemBind.Quest,
  ---The item is bound to the player's World of Warcraft account.
     ACCOUNT = Enum.ItemBind.ToWoWAccount,
  ---The item is bound to the player's Battle.net account.
     WARBAND = Enum.ItemBind.ToBnetAccount,
  ---The item is bound to the player's Battle.net account until equipped.
  WARBAND_EQ = Enum.ItemBind.ToBnetAccountUntilEquipped
}
