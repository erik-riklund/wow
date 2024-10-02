--[[~ Module: ? ~
  Created: 2024/10/02
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

  Features:

  - ?

]]

local palette = {
  ['donkey-brown'] = 'A39477',
  ['golden'] = 'EEC400',
  ['mango-orange'] = 'FF8040',
  ['olive-green'] = 'A9B665',
  ['saffron'] = 'FF9933',
  ['vanilla'] = 'D4BE98',
  ['white'] = 'FFFFFF',
}

---
--- ?
---
local parseColors = function(target)
  target = string.gsub(target, '</color>', '|r')

  return string.gsub(target, '<color:%s*([a-z]+[a-z-]*[a-z]*)>', function(color)
    return '|cFF' .. (palette[color] or palette['white'])
  end)
end

-- [explain this section]

table.insert(backbone.markupParsers, parseColors)
