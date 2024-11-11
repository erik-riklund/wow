--[[~ Module: Markup Handler ~
  Updated: ? | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
---@class MarkupHandler
---
backbone.markup = {}

---
--- ?
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
