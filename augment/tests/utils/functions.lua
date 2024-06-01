if not WoWUnit then return end
local WoWUnit = _G.WoWUnit --[[@as WoWUnit]]

--      #
--     # #   #    #  ####  #    # ###### #    # #####
--    #   #  #    # #    # ##  ## #      ##   #   #
--   #     # #    # #      # ## # #####  # #  #   #
--   ####### #    # #  ### #    # #      #  # #   #
--   #     # #    # #    # #    # #      #   ##   #
--   #     #  ####   ####  #    # ###### #    #   #
--
-- World of Warcraft addon ecosystem, created by Erik Riklund (2024)
--

local test = WoWUnit('utils: functions')

local equal = WoWUnit.AreEqual
local mock = WoWUnit.Replace
local revert = WoWUnit.ClearReplaces

--#region [ test: switch ]

function test:switch()
  local switch = _G.switch

  equal(nil, switch('hello', { howdy = 'greeting' }))
  equal(nil, switch(nil, { howdy = 'greeting' }))
  
  equal('greeting', switch('howdy', { howdy = 'greeting' }))
  equal('standard', switch(nil, { howdy = 'greeting', default = 'standard' }))
  equal('standard', switch('hello', { howdy = 'greeting', default = 'standard' }))
end

--#endregion
