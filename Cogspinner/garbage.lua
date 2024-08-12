--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local _, context = ...

--#region (locally scoped global variables)
--
--- Creates local references to frequently used global functions and tables,
--- improving performance by avoiding repeated global lookups during runtime.
--

local C_Timer = C_Timer

local collectgarbage, UnitIsAFK, UnitOnTaxi =
    collectgarbage, UnitIsAFK, UnitOnTaxi

--#endregion

--
--- ?

local plugin = context.plugin --[[@as plugin]]

--
--- Use the 'PLAYER_ENTERING_WORLD' event to trigger a full
--- garbage collection cycle after loading screens.
--
plugin.event:listen(
  {
    event = 'PLAYER_ENTERING_WORLD',
    callback = function() collectgarbage() end
  }
)

--
--- Use the 'PLAYER_FLAGS_CHANGED' event to trigger a full
--- garbage collection cycle when the player goes AFK.
---
--- (We employ a 5s delay to ensure the player didn't cancel AFK straight away.)
--
plugin.event:listen(
  {
    event = 'PLAYER_FLAGS_CHANGED',
    callback = function(unit)
      if unit == 'player' and UnitIsAFK(unit) then
        C_Timer.After(5, function()
          if UnitIsAFK('player') then collectgarbage() end
        end)
      end
    end
  }
)

--
--- Use the 'UNIT_ENTERED_VEHICLE' event to trigger a full
--- garbage collection cycle when the player enters a taxi.
--
plugin.event:listen(
  {
    event = 'UNIT_ENTERED_VEHICLE',
    callback = function(unit)
      if unit == 'player' and UnitOnTaxi(unit) then collectgarbage() end
    end
  }
)
