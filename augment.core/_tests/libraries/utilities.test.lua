local _, CORE = ...

--
--      #
--     # #   #    #  ####  #    # ###### #    # #####
--    #   #  #    # #    # ##  ## #      ##   #   #
--   #     # #    # #      # ## # #####  # #  #   #
--   ####### #    # #  ### #    # #      #  # #   #
--   #     # #    # #    # #    # #      #   ##   #
--   #     #  ####   ####  #    # ###### #    #   #
--
-- World of Warcraft addon framework, created by Erik Riklund (2024)
--

--- @cast CORE framework

if not WoWUnit then return end
local WoWUnit = _G.WoWUnit --[[@as WoWUnit]]
local test = WoWUnit('library: utilities')

local equal = WoWUnit.AreEqual
local mock = WoWUnit.Replace
local revert = WoWUnit.ClearReplaces

--#region [test: when]

function test.when()
  local when = CORE.libs.utilities.when

  equal(nil, when('hello', { howdy = 'greeting' }))
  equal(nil, when(nil, { howdy = 'greeting' }))
  
  equal('greeting', when('howdy', { howdy = 'greeting' }))
  equal('standard', when(nil, { howdy = 'greeting', default = 'standard' }))
  equal('standard', when('hello', { howdy = 'greeting', default = 'standard' }))
end

--#endregion