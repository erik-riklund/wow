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

SAConfig = {}
SAItemList = {}

------------------------
-- USER CONFIGURATION --
------------------------

-- Autoloot all quest items? If disabled, quest items will only be looted
-- when they drop alone (e.g. from gathering objects) or if specified in the
-- list of quest items located in 'itemlist.lua'.
SAConfig["QUEST_LOOT_ALL"] = 0

-- The maximum amount of gold to autoloot:
SAConfig["GOLD_LOOT_MAX"] = 50

-- The minimum and maximum value (in copper) of grey items to loot: (10,000c = 1g)
-- Note: When handling junk from fishing, only the maximum price is taken into account!
SAConfig["JUNK_MINPRICE"] = 1999
SAConfig["JUNK_MAXPRICE"] = 99999

-- This will override the JUNK_MINPRICE if enabled and the character has Skinning learned.
-- Note: This will cause all junk below JUNK_MAXPRICE to be looted, regardless of the loot source (not only from beasts).
SAConfig["JUNK_SKINNING_OVERRIDE"] = 0

-- The tradeskill subtypes that should be looted:
-- https://wowpedia.fandom.com/wiki/ItemType
SAConfig["TRADESKILL_SUBTYPES"] = { "Cloth", "Herb", "Leather", "Metal & Stone" }

-- This determines the quality cap for autolooting tradeskill items with the aforementioned subtypes:
-- Common = 1, Uncommon = 2, Rare = 3, Epic = 4 (default is 3, which will loot tradegoods below rare quality)
SAConfig["TRADESKILL_QUALITY_CAP"] = 3

-- These currency types will not be looted:
SAConfig["CURRENCY_IGNORE"] = {
  -- Shadowlands
  "Soul Ash", "Soul Cinders", "Cosmic Flux", "Cyphers of the First Ones",
  -- Draenor & Legion
  "Garrison Resources", "Order Resources"
}

-- Autoloot rare/epic BoP weapons and armor?
SAConfig["LOOT_GEAR"] = 1

-- The maximum item-level that will be looted:
SAConfig["LOOT_GEAR_CAP"] = 199

-- The character's required minimum level for this to be active:
SAConfig["LOOT_GEAR_PLAYER_LEVEL"] = 60

-- Should appearances be taken into account? If so, only known ones will be looted:
-- (Note: All items must be looted manually once, even if the appearance is unlocked already from a different item)
SAConfig["LOOT_GEAR_ONLY_KNOWN"] = 1
