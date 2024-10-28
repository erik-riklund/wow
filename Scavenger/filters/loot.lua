---@class Scavenger
local context = select(2, ...)

--[[~ Module: Loot Filters ~
  Updated: 2024/10/28 | Author(s): Erik Riklund (Gopher)
]]

context.loot = {
  --
  -- Classic

  [6522]  = true, -- Deviate Fish
  [6359]  = true, -- Firefin Snapper
  [58503] = true, -- Hardened Walleye (quest item)
  [13757] = true, -- Lightning Eel
  [6358]  = true, -- Oily Blackmouth
  [13422] = true, -- Stonescale Eel

  --
  -- The Burning Crusade

  [22572] = true, -- Mote of Air
  [22573] = true, -- Mote of Earth
  [22574] = true, -- Mote of Fire
  [22575] = true, -- Mote of Life
  [22576] = true, -- Mote of Mana
  [22577] = true, -- Mote of Shadow
  [22578] = true, -- Mote of Water

  --
  -- Wrath of the Lich King

  [52027] = true, -- Conqueror's Mark of Sanctification
  [52030] = true, -- Conqueror's Mark of Sanctification (heroic)
  [37700] = true, -- Crystallized Air
  [37701] = true, -- Crystallized Earth
  [37702] = true, -- Crystallized Fire
  [37704] = true, -- Crystallized Life
  [37703] = true, -- Crystallized Shadow
  [37705] = true, -- Crystallized Water
  [52026] = true, -- Protector's Mark of Sanctification
  [52029] = true, -- Protector's Mark of Sanctification (heroic)
  [52025] = true, -- Vanquisher's Mark of Sanctification
  [52028] = true, -- Vanquisher's Mark of Sanctification (heroic)

  --
  -- Cataclysm

  [52328] = true, -- Volatile Air
  [52327] = true, -- Volatile Earth
  [52325] = true, -- Volatile Fire
  [52329] = true, -- Volatile Life
  [52326] = true, -- Volatile Water

  --
  -- Warlords of Draenor

  [120945] = true, -- Primal Spirit

  --
  -- Legion

  [137677] = true, -- Fel Blood (quest item)
  [129894] = true, -- Stormscale Spark (quest item)
  [124438] = true, -- Unbroken Claw
  [124439] = true, -- Unbroken Tooth
  [129888] = true, -- Undivided Hide (quest item)

  --
  -- Shadowlands

  [189864] = true, -- Anima Gossamer
  [186204] = true, -- Anima-Stained Glass Shards
  [184152] = true, -- Bottle of Diluted Anima-Wine
  [184148] = true, -- Concealed Sinvyr Flask
  [187322] = true, -- Crumbling Stone Tablet
  [181551] = true, -- Depleted Stoneborn Heart
  [185754] = true, -- Devoured Anima (quest item)
  [187457] = true, -- Engraved Glass Pane
  [187324] = true, -- Gnawed Ancient Idol
  [186200] = true, -- Infused Dendrite
  [188740] = true, -- Korthian Repository (quest item)
  [181388] = true, -- Lush Marrowroot
  [184307] = true, -- Maldraxxi Armor Scraps
  [178061] = true, -- Malleable Flesh
  [185751] = true, -- Mawsworn Emblem (quest item)
  [184386] = true, -- Nascent Sporepod
  [181642] = true, -- Novice Principles of Plaguistry
  [186685] = true, -- Relic Fragment
  [180009] = true, -- Resonating Anima Mote
  [184770] = true, -- Roster of the Forgotten
  [181969] = true, -- Rugged Carapace (quest item)
  [187323] = true, -- Runic Diagram
  [184146] = true, -- Singed Soul Shackles
  [184306] = true, -- Soulcatching Sludge
  [187460] = true, -- Strangely Intricate Key
  [178550] = true, -- Tenebrous Truffle
  [177061] = true, -- Twilight Bark
  [187458] = true, -- Unearthed Teleporter Sigil
  [181644] = true, -- Unlabeled Culture Jars
  [187459] = true, -- Vial of Mysterious Liquid
  [186202] = true, -- Wafting Koricone
  [181643] = true, -- Weeping Corpseshroom

  --
  -- Dragonflight

  [197754] = true, -- Salt Deposit

  --
  -- The War Within

  [223512] = true, -- Basically Beef
  [232047] = true, -- Chunk of Companion Experience (common)
  [220737] = true, -- Storm Spirit (quest item)
}

-- [] = true, -- 
