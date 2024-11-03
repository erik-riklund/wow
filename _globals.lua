---@meta

DevTools_Dump = function(data) end

---@type fun(): expansionLevel: number
GetExpansionLevel = function() end

---@type fun(): locale: string
GetLocale = function() end

---@type fun(): time: number
GetTime = function() end

---@type fun(unit: string): number
UnitLevel = function(unit) end

---@type Frame
LootFrame = nil

---@type Frame
UIParent = nil

---
---@class C_Item
---
---@field GetItemInfo fun(item: number|string): name: string, link: string, quality: number, baseItemLevel: number, requiredPlayerLevel: number, itemType: string, itemSubType: string, stackCount: number, equipLocation: string, texture: number, sellPrice: number, itemTypeId: number, itemSubTypeId: number, bindType: number, expansionId: number, setId: number?, isCraftingReagent: boolean
---
---@field GetDetailedItemLevelInfo fun(item: number|string): effectiveItemLevel: number, isPreview: boolean, baseItemLevel: number
---
C_Item = {}

---
---@class C_TransmogCollection
---
---@field PlayerHasTransmogByItemInfo fun(itemInfo: string): hasTransmog: boolean
---
C_TransmogCollection = {}
