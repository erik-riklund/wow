
--[[~ Updated: 2024/11/20 | Author(s): Gopher ]]

---
--- ?
---
---@enum ITEM_BIND
---
E_ITEM_BIND =
{
              NONE = Enum.ItemBind.None,
        ON_ACQUIRE = Enum.ItemBind.OnAcquire,
          ON_EQUIP = Enum.ItemBind.OnEquip,
            ON_USE = Enum.ItemBind.OnUse,
             QUEST = Enum.ItemBind.Quest,
           ACCOUNT = Enum.ItemBind.ToWoWAccount,
           WARBAND = Enum.ItemBind.ToBnetAccount,
  WARBAND_EQUIPPED = Enum.ItemBind.ToBnetAccountUntilEquipped
}
