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
      if unit == 'player' and UnitIsAFK 'player' then collectgarbage 'collect' end
    end
  }
)

---
--- ?
---
plugin:registerEventListener(
  'UNIT_ENTERED_VEHICLE',
  {
    identifier = 'UNIT_ENTERED_VEHICLE',

    ---@param unit string
    callback = function(unit)
      if unit == 'player' and UnitOnTaxi 'player' then collectgarbage 'collect' end
    end
  }
)
