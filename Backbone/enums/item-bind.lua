--[[~ Item bind type (enum) ~
  Updated: 2024/11/20 | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
---@enum ITEM_BIND
---
E_ITEM_BIND =
{
  NONE          = 0,
  ON_ACQUIRE    = 1,
  ON_EQUIP      = 2,
  ON_USE        = 3,
  QUEST         = 4,
  ACCOUNT       = 7,
  WARBAND       = 8,
  WARBAND_EQUIP = 9
}
