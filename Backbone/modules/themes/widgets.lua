---@class Backbone
local context = select(2, ...)

--[[~ Themes ~
  Updated: 2024/11/01 | Author(s): Erik Riklund (Gopher)
]]

---
--- Registers a callback function to be executed when the color theme is changed.
---
---@param callback function
---
backbone.widgets.onThemeChange = function(callback)
  backbone.registerChannelListener(
    context.plugin, 'COLOR_THEME_CHANGED', { callback = callback }
  )

  callback() -- execute the callback to initialize the widget.
end
