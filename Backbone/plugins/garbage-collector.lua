--[[~ Garbage collector (plugin) ~
  Updated: 2024/11/21 | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
---
local plugin = backbone.createPlugin 'BackboneGarbageCollector'

---
--- ?
---
plugin:registerEventListener(
  'PLAYER_ENTERING_WORLD',
  {
    identifier = 'PLAYER_ENTERING_WORLD',
    callback = function() collectgarbage 'collect' end
  }
)

---
--- ?
---
plugin:registerEventListener(
  'PLAYER_FLAGS_CHANGED',
  {
    identifier = 'PLAYER_FLAGS_CHANGED',

    ---@param unit string
    callback = function(unit)
      print(unit) -- debug!
    end
  }
)
