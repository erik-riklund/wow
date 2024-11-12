--[[~ Markup Handler ~
  Updated: 2024/11/12 | Author(s): Erik Riklund (Gopher)
]]

---
--- A utility for handling markup in text based on tag type.
---
---@class MarkupHandler
---
backbone.markup = {}

---
--- Colorizes specific tags (info|warning|error) in the
--- target string, applying appropriate color codes.
---
---@param target string
---
backbone.markup.colorize = function(target)
  target = string.gsub(target, '</([a-z]+)>', function(type)
    return ((type == 'info' or type == 'warning' or type == 'error') and '|r') or type --
  end)

  target = string.gsub(target, '<([a-z]+)>', function(type)
    if type == 'info' or type == 'warning' or type == 'error' then
      return '|cFF' .. backbone.utilities.rgbToHex(backbone.getColor(type .. 'TextColor')) --
    end

    return type
  end)

  return target
end
