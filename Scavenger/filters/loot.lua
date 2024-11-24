---@class Scavenger
local context = select(2, ...)

--[[~ Lootable items (filter) ~
  Updated: 2024/11/20 | Author(s): Erik Riklund (Gopher)
]]



context.loot = {
  --
  -- Classic

  ['6522']  = true, -- Deviate Fish
  ['6359']  = true, -- Firefin Snapper
  ['58503'] = true, -- Hardened Walleye (quest item)
  ['13757'] = true, -- Lightning Eel
  ['6358']  = true, -- Oily Blackmouth
  ['13422'] = true, -- Stonescale Eel
  ['58899'] = true, -- Violet Perch (quest item)

  --
  -- The Burning Crusade

  ['22572'] = true, -- Mote of Air
  ['22573'] = true, -- Mote of Earth
  ['22574'] = true, -- Mote of Fire
  ['22575'] = true, -- Mote of Life
  ['22576'] = true, -- Mote of Mana
  ['22577'] = true, -- Mote of Shadow
  ['22578'] = true, -- Mote of Water

  --
  -- Wrath of the Lich King

  ['52027'] = true, -- Conqueror's Mark of Sanctification
  ['52030'] = true, -- Conqueror's Mark of Sanctification (heroic)
  ['37700'] = true, -- Crystallized Air
  ['37701'] = true, -- Crystallized Earth
  ['37702'] = true, -- Crystallized Fire
  ['37704'] = true, -- Crystallized Life
  ['37703'] = true, -- Crystallized Shadow
  ['37705'] = true, -- Crystallized Water
  ['52026'] = true, -- Protector's Mark of Sanctification
  ['52029'] = true, -- Protector's Mark of Sanctification (heroic)
  ['52025'] = true, -- Vanquisher's Mark of Sanctification
  ['52028'] = true, -- Vanquisher's Mark of Sanctification (heroic)

  --
  -- Cataclysm

  ['52328'] = true, -- Volatile Air
  ['52327'] = true, -- Volatile Earth
  ['52325'] = true, -- Volatile Fire
  ['52329'] = true, -- Volatile Life
  ['52326'] = true, -- Volatile Water

  --
  -- Warlords of Draenor

  ['120945'] = true, -- Primal Spirit

  --
  -- Legion

  ['137677'] = true, -- Fel Blood (quest item)
  ['129894'] = true, -- Stormscale Spark (quest item)
  ['124438'] = true, -- Unbroken Claw
  ['124439'] = true, -- Unbroken Tooth
  ['129888'] = true, -- Undivided Hide (quest item)

  --
  -- Shadowlands

  ['189864'] = true, -- Anima Gossamer
  ['186204'] = true, -- Anima-Stained Glass Shards
  ['184152'] = true, -- Bottle of Diluted Anima-Wine
  ['184148'] = true, -- Concealed Sinvyr Flask
  ['187322'] = true, -- Crumbling Stone Tablet
  ['181551'] = true, -- Depleted Stoneborn Heart
  ['185754'] = true, -- Devoured Anima (quest item)
  ['187457'] = true, -- Engraved Glass Pane
  ['187324'] = true, -- Gnawed Ancient Idol
  ['186200'] = true, -- Infused Dendrite
  ['188740'] = true, -- Korthian Repository (quest item)
  ['181388'] = true, -- Lush Marrowroot
  ['184307'] = true, -- Maldraxxi Armor Scraps
  ['178061'] = true, -- Malleable Flesh
  ['185751'] = true, -- Mawsworn Emblem (quest item)
  ['184386'] = true, -- Nascent Sporepod
  ['181642'] = true, -- Novice Principles of Plaguistry
  ['186685'] = true, -- Relic Fragment
  ['180009'] = true, -- Resonating Anima Mote
  ['184770'] = true, -- Roster of the Forgotten
  ['181969'] = true, -- Rugged Carapace (quest item)
  ['187323'] = true, -- Runic Diagram
  ['184146'] = true, -- Singed Soul Shackles
  ['184306'] = true, -- Soulcatching Sludge
  ['187460'] = true, -- Strangely Intricate Key
  ['178550'] = true, -- Tenebrous Truffle
  ['177061'] = true, -- Twilight Bark
  ['187458'] = true, -- Unearthed Teleporter Sigil
  ['181644'] = true, -- Unlabeled Culture Jars
  ['187459'] = true, -- Vial of Mysterious Liquid
  ['186202'] = true, -- Wafting Koricone
  ['181643'] = true, -- Weeping Corpseshroom

  --
  -- Dragonflight

  ['202071'] = true, -- Elemental Mote
  ['202070'] = true, -- Exceptional Pelt
  ['200695'] = true, -- Fangtooth Petals
  ['192615'] = true, -- Fluorescent Fluid
  ['191100'] = true, -- Fresh Game Meat (quest item)
  ['200704'] = true, -- Gratona Seed
  ['192658'] = true, -- High-Fiber Leaf
  ['200699'] = true, -- Milkweed Fibers
  ['200553'] = true, -- Panthis Nectar
  ['192545'] = true, -- Primal Flame Fragment (quest item)
  ['200694'] = true, -- River Bell Bulbs
  ['197754'] = true, -- Salt Deposit
  ['199206'] = true, -- Shattered Adamant Scales
  ['191541'] = true, -- Shikaar Supplies (quest item)
  ['198349'] = true, -- Stolen Dragonscale Supplies (quest item)
  ['200705'] = true, -- Thaldraszus Root
  ['200701'] = true, -- Titian Extract
  ['199204'] = true, -- Torn Resilient Leather Scraps
  ['200703'] = true, -- Vine Flower Fibers
  ['200222'] = true, -- White Bell Pigment
  ['192636'] = true, -- Woolly Mountain Pelt

  --
  -- The War Within

  ['232047'] = true, -- Chunk of Companion Experience (common)
  ['220737'] = true, -- Storm Spirit (quest item)
}

-- [''] = true, -- 
