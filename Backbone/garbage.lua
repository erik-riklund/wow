---@type string, contextProvider
local addon, repository = ...
local plugin = repository.use 'backbone-plugin' --[[@as plugin]]

--[[~ Module: Garbage Collection ~

  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/28

  This module registers event listeners for garbage collection optimization. It listens for 
  specific game events related to the player's state (e.g., entering the world, changing flags, 
  or entering a vehicle) and triggers garbage collection when appropriate conditions are met.

  Features:

  - Optimize memory usage by triggering garbage collection during specific player events.

]]

---
--- This event listener triggers garbage collection when the player enters the game world. It
--- is registered with the 'PLAYER_ENTERING_WORLD' event, ensuring that memory is cleaned up
--- when the player loads into the game.
---
plugin:registerEventListener('PLAYER_ENTERING_WORLD', {
  identifier = 'GARBAGE.PLAYER_ENTERING_WORLD',
  callback = function() collectgarbage() end,
})

---
--- This event listener triggers garbage collection if the player goes AFK. It is registered
--- with the 'PLAYER_FLAGS_CHANGED' event and checks if the player is flagged as AFK. If the
--- player remains AFK for 5 seconds, garbage collection is triggered.
---
plugin:registerEventListener('PLAYER_FLAGS_CHANGED', {
  identifier = 'GARBAGE.PLAYER_FLAGS_CHANGED',
  ---@param unit string
  callback = function(unit)
    -- Check if the unit is the player and if the player is currently AFK. If the player remains
    -- AFK for 5 seconds, trigger garbage collection to free up memory during inactivity.

    if unit == 'player' and UnitIsAFK 'player' then
      C_Timer.After(5, function(cb)
        if UnitIsAFK 'player' then collectgarbage() end
      end)
    end
  end,
})

---
--- This event listener triggers garbage collection when the player enters a vehicle or boards
--- a taxi. It listens for the 'UNIT_ENTERED_VEHICLE' event and checks if the player is on a taxi.
--- If so, garbage collection is triggered to optimize memory during travel sequences.
---
plugin:registerEventListener('UNIT_ENTERED_VEHICLE', {
  identifier = 'GARBAGE.UNIT_ENTERED_VEHICLE',
  ---@param unit string
  callback = function(unit)
    if unit == 'player' and UnitOnTaxi 'player' then collectgarbage() end
  end,
})
