--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local addon, context = ...

--#region: initialization

--
--- ?

local assert = contraption.assert

--
--- ?

local plan = context.tests --[[@as testing.plan]]

--#endregion

--#region [test suite: string.split]

--
--- ?

local split = plan:suite('utilities: string.split')

--
--- ?

split:test(
  {
    label = 'should do something?',
    callback = function()
      return assert.equal()
    end
  }
)

--#endregion
