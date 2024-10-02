--[[~ Module: ? ~
  Created: 2024/10/02
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

  Features:

  - ?

]]

local palette = {
  -- Reds
  ['light-red'] = 'FF7F7F', -- Light red
  ['red'] = 'FF0000', -- Normal red
  ['dark-red'] = '8B0000', -- Dark red

  -- Greens
  ['light-green'] = '90EE90', -- Light green
  ['green'] = '008000', -- Normal green
  ['dark-green'] = '006400', -- Dark green

  -- Blues
  ['light-blue'] = 'ADD8E6', -- Light blue
  ['blue'] = '0000FF', -- Normal blue
  ['dark-blue'] = '00008B', -- Dark blue

  -- Yellows
  ['light-yellow'] = 'FFFFE0', -- Light yellow
  ['yellow'] = 'FFFF00', -- Normal yellow
  ['dark-yellow'] = 'CCCC00', -- Dark yellow

  -- Oranges
  ['light-orange'] = 'FFD580', -- Light orange
  ['orange'] = 'FFA500', -- Normal orange
  ['dark-orange'] = 'FF8C00', -- Dark orange

  -- Purples
  ['light-purple'] = 'DDA0DD', -- Light purple
  ['purple'] = '800080', -- Normal purple
  ['dark-purple'] = '4B0082', -- Dark purple

  -- Browns
  ['light-brown'] = 'D2B48C', -- Light brown
  ['brown'] = 'A52A2A', -- Normal brown
  ['dark-brown'] = '654321', -- Dark brown

  -- Grays
  ['light-gray'] = 'D3D3D3', -- Light gray
  ['gray'] = '808080', -- Normal gray
  ['dark-gray'] = '505050', -- Dark gray

  -- Pinks
  ['light-pink'] = 'FFB6C1', -- Light pink
  ['pink'] = 'FFC0CB', -- Normal pink
  ['dark-pink'] = 'FF69B4', -- Dark pink

  -- Teals
  ['light-teal'] = 'B2DFE9', -- Light teal
  ['teal'] = '008080', -- Normal teal
  ['dark-teal'] = '005F5F', -- Dark teal

  -- Blacks
  ['light-black'] = '2F2F2F', -- Light black (charcoal)
  ['black'] = '000000', -- Normal black
  ['dark-black'] = '0B0B0B', -- Dark black (jet black)

  -- Whites
  ['light-white'] = 'FFFFFF', -- Pure white
  ['white'] = 'F5F5F5', -- Off white
  ['dark-white'] = 'E5E5E5', -- Darker white (grayish white)
}

---
---
---
local parseColors = function(target) end

-- [explain this section]

table.insert(backbone.markupParsers, parseColors)
