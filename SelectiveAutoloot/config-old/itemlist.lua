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

-- Items that shouldn't be looted:
SAItemList["Ignore"] = {
  -- Classic --
  [0] = {
    "Spider's Silk", "Thick Spider's Silk", "Ironweb Spider Silk", "Shadow Silk", "Light Hide", "Medium Hide",
    "Heavy Hide", "Thick Hide", "Rugged Hide", "Devilsaur Leather", "Warbear Leather", "Green Whelp Scale",
    "Thick Murloc Scale", "Scorpid Scale", "Guardian Stone", "Deeprock Salt"
  },

  -- Outland --
  [1] = {
    "Fel Hide"
  },

  -- Northrend --
  [2] = {
    "Frost Lotus"
  },

  -- Cataclysm --
  [3] = {

  },

  -- Mists of Pandaria --
  [4] = {

  },

  -- Warlords of Draenor --
  [5] = {

  },

  -- Legion --
  [6] = {
    "Felhide", "Felwort", "Infernal Brimstone"
  },

  -- Battle for Azeroth --
  [7] = {

  },

  -- Shadowlands --
  [8] = {
    "Lightless Silk"
  },

  -- Dragonflight --
  [9] = {

  }
}

-- Custom items that should be looted:
SAItemList["Custom"] = {
  -- Classic --
  [0] = {

  },

  -- Outland --
  [1] = {

  },

  -- Northrend --
  [2] = {
    "Vanquisher's Mark of Sanctification", "Conqueror's Mark of Sanctification", "Protector's Mark of Sanctification"
  },

  -- Cataclysm --
  [3] = {

  },

  -- Mists of Pandaria --
  [4] = {

  },

  -- Warlords of Draenor --
  [5] = {

  },

  -- Legion --
  [6] = {
    "Unbroken Tooth", "Unbroken Claw"
  },

  -- Battle for Azeroth --
  [7] = {

  },

  -- Shadowlands --
  [8] = {
    "Malleable Flesh", "Relic Fragment", "Gnawed Ancient Idol", "Anima-Stained Glass Shards", "Infused Dendrite",
    "Wafting Koricone", "Crumbling Stone Tablet", "Strangely Intricate Key", "Vial of Mysterious Liquid",
    "Unlabeled Culture Jars", "Roster of the Forgotten", "Maldraxxi Armor Scraps", "Soulcatching Sludge",
    "Weeping Corpseshroom", "Twilight Bark", "Nascent Sporepod", "Runic Diagram", "Resonating Anima Mote",
    "Singed Soul Shackles", "Concealed Sinvyr Flask", "Bottle of Diluted Anima-Wine", "Engraved Glass Pane",
    "Unearthed Teleporter Sigil", "Depleted Stoneborn Heart", "Novice Principles of Plaguistry", "Lush Marrowroot",
    "Anima Gossamer", "Tenebrous Truffle"
  },

  -- Dragonflight --
  [9] = {
    "Salt Deposit"
  }
}

-- Quest items that should be looted:
SAItemList["Quests"] = {
  -- Classic --
  "Hardened Walleye",

  -- Legion --
  "Fel Blood", "Undivided Hide", "Stormscale Spark",

  -- Shadowlands --
  "Devoured Anima", "Mawsworn Emblem", "Rugged Carapace", "Korthian Repository"
}

-- List of special fishies:
SAItemList["Fish"] = {
  -- Classic --
  "Deviate Fish", "Oily Blackmouth", "Firefin Snapper", "Stonescale Eel", "Lightning Eel"
}

-- Common elemental items:
SAItemList["Elementals"] = {
  -- Draenor --
  "Primal Spirit",

  -- Northrend --
  "Crystallized Fire", "Crystallized Earth", "Crystallized Life", "Crystallized Water", "Crystallized Shadow",
  "Crystallized Air",

  -- Outland --
  "Mote of Earth", "Mote of Fire", "Mote of Air", "Mote of Water", "Mote of Mana", "Mote of Shadow", "Mote of Life",

  -- Cataclysm --
  "Volatile Earth", "Volatile Fire", "Volatile Life", "Volatile Water", "Volatile Air",

  -- Dragonflight --
  --"Rousing Earth","Rousing Fire","Rousing Air","Rousing Water","Rousing Order"
}

-- Pigments that should be looted:
SAItemList["Pigments"] = {
  "Alabaster Pigment", "Dusky Pigment", "Golden Pigment", "Emerald Pigment", "Violet Pigment",
  "Silvery Pigment", "Nether Pigment", "Azure Pigment", "Ashen Pigment", "Shadow Pigment",
  "Cerulean Pigment", "Roseate Pigment", "Ultramarine Pigment", "Crimson Pigment", "Maroon Pigment",
  "Luminous Pigment", "Umbral Pigment"
}
