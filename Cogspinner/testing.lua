--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local addon, context = ...

--#region: locally scoped variables

local map = cogspinner.utility.collection.map
local list = cogspinner.utility.collection.list

--#endregion

--#region [API: suite]

--
--- ?
--
local suite_api = {}

--#endregion

--#region [API: plan]

--
--- ?
--
local plan_api = {}

--
--- ?
---
--- @param self testing.plan
--- @param label string
---
--- @return testing.suite
--
function plan_api.suite(self, label)
  local suite = { tests = list() }
  self.suites:set(label, suite)

  return setmetatable(suite, { __index = suite_api })
end

--#endregion

--#region [module: controller]

--
--- ?
--
local test_controller = {}

--
--- ?
---
--- @param plan testing.plan
--
function test_controller:execute(plan) end

--#endregion

--#region [module: manager]

--
--- ?
--
local test_manager = {}

--
--- ?
---
--- @param plugin plugin
--- @return testing.plan
--
function test_manager:setup(plugin)
  local plan = { context = plugin, suites = list() }
  plugin:onload(function() test_controller:execute(plan) end)

  return setmetatable(plan, { __index = plan_api })
end

--#endregion

--#region [module: assertions]

--
--- ?
--
local assert = {}

--
--- ?
--
function assert.equal() end

--#endregion

--#region [API: testing framework]

--
--- ?
--
_G.contraption =
{
  assert = assert,

  --
  --- ?
  ---
  --- @param plugin plugin
  --
  setup = function(plugin)
    return test_manager:setup(plugin)
  end
}

--#endregion
