--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|
--
local collectgarbage = _G.collectgarbage

--
-- Optimizes memory usage by triggering garbage collection during specific game events.
--
local plugin = cogspinner.createPlugin('GarbageCollector')

--
-- Performs a garbage collection cycle when the player enters the world.
--
plugin:registerEventListener('PLAYER_ENTERING_WORLD', {
  callback = function()
    collectgarbage()
  end
})

--
-- Triggers a garbage collection cycle after the player has been AFK for 5 seconds.
--
plugin:registerEventListener('PLAYER_FLAGS_CHANGED', {
  callback = function(unit)
    local setTimer = C_Timer.After
    local unitIsAfk = _G.UnitIsAFK

    -- ~ Check if the event is for the player and if they are AFK.

    if unit == 'player' and unitIsAfk(unit) then
      setTimer(5, function()
        -- ~ Run garbage collection only if the player is still AFK.
        if unitIsAfk('player') then
          collectgarbage()
        end
      end)
    end
  end
})

--
-- Performs a garbage collection cycle when the player
-- enters a vehicle, such as a taxi (flight path).
--
plugin:registerEventListener('UNIT_ENTERED_VEHICLE', {
  callback = function(unit)
    local unitOnTaxi = _G.UnitOnTaxi

    if unit == 'player' and unitOnTaxi(unit) then
      collectgarbage()
    end
  end
})
