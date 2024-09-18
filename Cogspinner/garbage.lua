--
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, framework
local addon, framework = ...

--- @type events.handler
local eventHandler = framework.import('events/handler')

--
--- Use the 'PLAYER_ENTERING_WORLD' event to trigger a full
--- garbage collection cycle after loading screens.
--
eventHandler.registerListener('PLAYER_ENTERING_WORLD', {
  callback = function()
    collectgarbage()
  end
})

--
--- Use the 'PLAYER_FLAGS_CHANGED' event to trigger a full garbage
--- collection cycle when the player goes AFK.
---
--- (We employ a 5s delay to ensure the player didn't cancel AFK straight away.)
--
eventHandler.registerListener('PLAYER_FLAGS_CHANGED', {
  callback = function(unit)
    if unit == 'player' and UnitIsAFK('player') then
      local callback = function()
        if UnitIsAFK('player') then
          collectgarbage()
        end
      end

      C_Timer.After(5, callback)
    end
  end
})

--
--- Use the 'UNIT_ENTERED_VEHICLE' event to trigger a full garbage
--- collection cycle when the player enters a taxi.
--
eventHandler.registerListener('UNIT_ENTERED_VEHICLE', {
  callback = function(unit)
    if unit == 'player' and UnitOnTaxi('player') then
      collectgarbage()
    end
  end
})
