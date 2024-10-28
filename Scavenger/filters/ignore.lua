---@class Scavenger
local context = select(2, ...)

--[[~ Module: Loot Filters ~
  Updated: 2024/10/28 | Author(s): Erik Riklund (Gopher)
]]

context.ignore = {
  --
  -- Classic
  
  [8150]  = true, -- Deeprock Salt
  [15417] = true, -- Devilsaur Leather
  [7392]  = true, -- Green Whelp Scale
  [12809] = true, -- Guardian Stone
  [4235]  = true, -- Heavy Hide
  [14227] = true, -- Ironweb Spider Silk
  [783]   = true, -- Light Hide
  [4232]  = true, -- Medium Hide
  [8171]  = true, -- Rugged Hide
  [8154]  = true, -- Scorpid Scale
  [10285] = true, -- Shadow Silk
  [3182]  = true, -- Spider's Silk
  [8169]  = true, -- Thick Hide
  [5785]  = true, -- Thick Murloc Scale
  [4337]  = true, -- Thick Spider's Silk
  [15419] = true, -- Warbear Leather

  --
  -- The Burning Crusade

  [25707] = true, -- Fel Hide

  --
  -- Wrath of the Lich King

  [36908] = true, -- Frost Lotus

  --
  -- Legion

  [124116] = true, -- Felhide
  [124106] = true, -- Felwort
  [124444] = true, -- Infernal Brimstone

  --
  -- Shadowlands

  [173204] = true, -- Lightless Silk

  --
  -- The War Within

  [218338] = true, -- Bottled Storm
  [218339] = true, -- Burning Cinderbee Setae
  [225768] = true, -- Crusty Darkmoon Card
  [222533] = true, -- Goldengill Trout
  [218337] = true, -- Honed Bone Shards
  [220138] = true, -- Nibbling Minnow
  [220142] = true, -- Quiet River Bass
  [220141] = true, -- Specular Rainbowfish
}

-- [] = true, --
