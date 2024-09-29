---@type string, contextProvider
local addon, repository = ...
local plugin = repository.use 'backbone-plugin' --[[@as plugin]]

--[[~ Module: ? ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/28

  ?

  Features:

  - ?

  Dependencies: ?

]]

-- [explain what the purpose and result of this function is]

plugin:registerEventListener('PLAYER_ENTERING_WORLD', {
  identifier = 'GARBAGE.PLAYER_ENTERING_WORLD',
  callback = function() collectgarbage() end,
})

-- [explain what the purpose and result of this function is]

plugin:registerEventListener('PLAYER_FLAGS_CHANGED', {
  identifier = 'GARBAGE.PLAYER_FLAGS_CHANGED',
  ---@param unit string
  callback = function(unit)
    -- [explain this section up until the next placeholder]

    if unit == 'player' and UnitIsAFK 'player' then
      C_Timer.After(5, function(cb)
        if UnitIsAFK 'player' then collectgarbage() end
      end)
    end
  end,
})

-- [explain what the purpose and result of this function is]

plugin:registerEventListener('UNIT_ENTERED_VEHICLE', {
  identifier = 'GARBAGE.UNIT_ENTERED_VEHICLE',
  ---@param unit string
  callback = function(unit)
    if unit == 'player' and UnitOnTaxi 'player' then collectgarbage() end
  end,
})
