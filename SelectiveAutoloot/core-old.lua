---@diagnostic disable

--    _____      _           _   _
--   / ____|    | |         | | (_)
--  | (___   ___| | ___  ___| |_ ___   _____
--   \___ \ / _ \ |/ _ \/ __| __| \ \ / / _ \
--   ____) |  __/ |  __/ (__| |_| |\ V /  __/
--  |_____/ \___|_|\___|\___|\__|_| \_/ \___|
--     /\        | |      | |           | |
--    /  \  _   _| |_ ___ | | ___   ___ | |_
--   / /\ \| | | | __/ _ \| |/ _ \ / _ \| __|
--  / ____ \ |_| | || (_) | | (_) | (_) | |_
-- /_/    \_\__,_|\__\___/|_|\___/ \___/ \__|
--
-- by Ghuul (2024) v1.8
--

local SA = CreateFrame("Frame")

local Item = {}
local LootableSlots = {}
local EventList = { "PLAYER_LOGIN", "LOOT_READY", "LOOT_OPENED", "LOOT_CLOSED" }
local ItemCount, PlayerClass

local Transmog = {
  DRUID = { Armor = { 2, 5 }, Weapons = { 4, 5, 6, 10, 13, 15 } },
  DEATHKNIGHT = { Armor = { 4, 5 }, Weapons = { 0, 1, 4, 5, 6, 7, 8 } },
  DEMONHUNTER = { Armor = { 2, 5 }, Weapons = { 0, 7, 9, 13 } },
  HUNTER = { Armor = { 3, 5 }, Weapons = { 0, 1, 2, 3, 6, 7, 8, 10, 13, 15, 18 } },
  MAGE = { Armor = { 1, 5 }, Weapons = { 7, 10, 15, 19 } },
  MONK = { Armor = { 2, 5 }, Weapons = { 0, 4, 6, 7, 10, 13 } },
  PALADIN = { Armor = { 4, 5, 6 }, Weapons = { 0, 1, 4, 5, 6, 7, 8 } },
  PRIEST = { Armor = { 1, 5 }, Weapons = { 4, 10, 15, 19 } },
  ROGUE = { Armor = { 2, 5 }, Weapons = { 0, 2, 3, 4, 7, 13, 15, 16 } },
  SHAMAN = { Armor = { 3, 5, 6 }, Weapons = { 0, 1, 4, 5, 10, 13, 15 } },
  WARLOCK = { Armor = { 1, 5 }, Weapons = { 4, 10, 15, 19 } },
  WARRIOR = { Armor = { 4, 5, 6 }, Weapons = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 10, 13, 15, 16, 18 } },
  EVOKER = { Armor = { 3, 5 }, Weapons = { 0, 4, 7, 10, 13, 15 } }
}

SetCVar("autoLootDefault", 0)
for e = 1, #EventList do SA:RegisterEvent(EventList[e]) end

SA:SetScript("OnEvent", function(_, EVENT)
  -- Addon initialization:
  if EVENT == "PLAYER_LOGIN" then
    -- Determine what class the character is:
    PlayerClass = select(2, UnitClass("player"))

    -- Should we check for Skinning to override the minimum junk price?
    if SAConfig["JUNK_SKINNING_OVERRIDE"] == 1 and SAConfig["JUNK_MINPRICE"] > 1 then
      -- Determine what professions (if any) the character have selected:
      local P1, P2 = GetProfessions()
      local Profession1 = ""
      local Profession2 = ""
      if P1 ~= nil then Profession1 = GetProfessionInfo(P1) end
      if P2 ~= nil then Profession2 = GetProfessionInfo(P2) end
      if Profession1 == "Skinning" or Profession2 == "Skinning" then
        -- The character is a skinner!
        SAConfig["JUNK_MINPRICE"] = 1
      end
    end
    -- Loot detected:
  elseif EVENT == "LOOT_READY" then
    ItemCount = GetNumLootItems()
    if ItemCount > 0 then SA_ProcessLoot() end
    -- Loot window opened:
  elseif EVENT == "LOOT_OPENED" then
    if #LootableSlots > 0 then SA_LootSlots() end
    -- Loot window closed:
  elseif EVENT == "LOOT_CLOSED" then
    ItemCount = 0
    wipe(LootableSlots)
  end
end)

function SA_LootSlot(SLOT)
  tinsert(LootableSlots, SLOT)
end

function SA_LootSlots()
  for i = 1, #LootableSlots do
    LootSlot(LootableSlots[i])
  end
end

function SA_ProcessLoot()
  for i = ItemCount, 1, -1 do
    -- Get some basic info about the current item:
    local SlotType = GetLootSlotType(i)
    Item["Link"] = GetLootSlotLink(i)
    _, Item["Name"], _, _, Item["Quality"], Locked, QuestItem = GetLootSlotInfo(i)

    Item["Expansion"] = 0
    if SlotType ~= 3 and SlotType ~= 2 and not QuestItem then
      -- Fetch additional required info about the item:
      Item["Type"], Item["Subtype"], _, Item["EquipSlot"], _, Item["Price"], _, Item["SubtypeID"],
      Item["Bind"], Item["Expansion"] = select(6, GetItemInfo(Item["Link"]))
      if Item["Expansion"] == nil then Item["Expansion"] = 0 end
    end

    -- Check if the item is locked or should be ignored:
    if not Locked and not tContains(SAItemList["Ignore"][Item["Expansion"]], Item["Name"]) then
      -- Currency:
      if SlotType == 3 and not tContains(SAConfig["CURRENCY_IGNORE"], Item["Name"]) then
        SA_LootSlot(i)

        -- Quest-related items:
      elseif QuestItem and ((ItemCount == 1 or SAConfig["QUEST_LOOT_ALL"] == 1) or
            tContains(SAItemList["Quests"], Item["Name"])) then
        SA_LootSlot(i)

        -- Coins:
      elseif SlotType == 2 then
        local Cash = strsplit("\n", Item["Name"])
        local CashAmount, CashValue = strsplit(" ", Cash)
        if CashValue ~= "Gold" or (CashValue == "Gold" and tonumber(CashAmount) < SAConfig["GOLD_LOOT_MAX"]) then
          SA_LootSlot(i)
        end

        -- Low-quality items:
      elseif Item["Quality"] == 0 and not IsFishingLoot() then
        Item["Price"] = select(11, GetItemInfo(Item["Link"]))
        if Item["Price"] >= SAConfig["JUNK_MINPRICE"] and Item["Price"] <= SAConfig["JUNK_MAXPRICE"] then SA_LootSlot(i) end

        -- Analyze the item to determine if it should be looted:
      elseif SA_CurrentItemShouldBeLooted() then
        SA_LootSlot(i)
      end
    end
    -- Clear the current item:
    wipe(Item)
  end
end

function SA_CurrentItemShouldBeLooted()
  -- Is the item specified in the "custom loot" list?
  if tContains(SAItemList["Custom"][Item["Expansion"]], Item["Name"]) then
    return true

    -- Is the item used for Enchanting?
  elseif Item["Type"] == "Tradeskill" and Item["Subtype"] == "Enchanting" then
    return true

    -- Is the item used for Inscription?
  elseif Item["Type"] == "Tradeskill" and Item["Subtype"] == "Inscription" then
    return tContains(SAItemList["Pigments"], Item["Name"])

    -- Analyze fishing loot:
  elseif IsFishingLoot() then
    return (tContains(SAItemList["Fish"], Item["Name"])
      or (Item["Type"] == "Tradeskill" and Item["Subtype"] == "Cooking")
      or (Item["Quality"] == 0 and Item["Price"] <= SAConfig["JUNK_MAXPRICE"]))

    -- Elemental loot - check if the item is on the list of common reagents:
  elseif Item["Type"] == "Tradeskill" and Item["Subtype"] == "Elemental" then
    return tContains(SAItemList["Elementals"], Item["Name"])

    -- Tradeskill reagent - check the subtype and rarity of the item:
  elseif Item["Type"] == "Tradeskill" and tContains(SAConfig["TRADESKILL_SUBTYPES"], Item["Subtype"]) then
    return Item["Quality"] < SAConfig["TRADESKILL_QUALITY_CAP"]

    -- Armor/weapon - check all the required parameters:
  elseif (Item["Type"] == "Weapon" or Item["Type"] == "Armor") and SAConfig["LOOT_GEAR"] == 1
      and UnitLevel("player") >= SAConfig["LOOT_GEAR_PLAYER_LEVEL"] and Item["Bind"] == 1 then
    Item["Level"] = GetDetailedItemLevelInfo(Item["Link"])
    -- Determine if the quality and level is within looting range:
    if (Item["Quality"] == 3 or Item["Quality"] == 4) and Item["Level"] <= SAConfig["LOOT_GEAR_CAP"] then
      -- Loot all gear with no regard to transmog?
      if SAConfig["LOOT_GEAR_ONLY_KNOWN"] == 0 then return true end

      -- Now we need to check if the transmog appearance is usable:
      if Item["EquipSlot"] == "INVTYPE_CLOAK" or
          (Item["Type"] == "Weapon" and tContains(Transmog[PlayerClass].Weapons, Item.SubtypeID)) or
          (Item["Type"] == "Armor" and tContains(Transmog[PlayerClass].Armor, Item.SubtypeID)) then
        -- Check if the appearance is known from this specific item:
        return C_TransmogCollection.PlayerHasTransmogByItemInfo(Item["Link"])

        -- The item have no transmog value for this character so we'll just loot it!
      else
        return true
      end
    end
  end
  -- Item does not fit any of the operations above, do not loot!
  return false
end
