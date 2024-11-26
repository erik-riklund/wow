
--[[~ Updated: 2024/11/21 | Author(s): Gopher ]]

local plugin = backbone.createPlugin 'Backbone_GarbageCollector'

---Triggers a garbage collection pass whenever the player enters the world.
plugin:registerEventListener(
  'PLAYER_ENTERING_WORLD', {
    identifier = 'PLAYER_ENTERING_WORLD',
    callback = function() collectgarbage 'collect' end
  }
)

---Triggers a garbage collection pass if the player switches to AFK status.
plugin:registerEventListener(
  'PLAYER_FLAGS_CHANGED', {
    identifier = 'PLAYER_FLAGS_CHANGED',
    callback = function (unit)
      if unit == 'player' and B_Unit.isAFK 'player' then collectgarbage 'collect' end
    end
  }
)

---Triggers a garbage collection pass if the player enters a vehicle or taxi.
plugin:registerEventListener(
  'UNIT_ENTERED_VEHICLE', {
    identifier = 'UNIT_ENTERED_VEHICLE',
    callback = function (unit)
      if unit == 'player' and B_Unit.onTaxi 'player' then collectgarbage 'collect' end
    end
  }
)
