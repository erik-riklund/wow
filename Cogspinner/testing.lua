--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local addon, context = ...

--#region: locally scoped variables

--- @cast context { plugin: plugin }

--
--- ?

local cogspinner = cogspinner
local utility = cogspinner.utility
local _table = utility.table

--
--- ?

local type = type
local throw = utility.throw
local setmetatable = setmetatable
local list = utility.collection.list

--#endregion

--#region (initialization)

---
--- ?

context.plugin.network:reserve(
  {
    'TESTKIT:PLAN_COMPLETED',
    'TESTKIT:SUITE_COMPLETED',
    'TESTKIT:TEST_COMPLETED'
  }
)

--#endregion

--#region [API: test suite]

--
--- ?
--
local suite_api = {}

--#endregion

--#region [API: testkit]

--
--- ?
--
local testkit_api = {}

--
--- ?
---
--- @param self testkit
--- @param label string
--
function testkit_api.suite(self, label)
  --#region: ?
  -- ???
  --#endregion



  local suite = { label = label, tests = list(), context = {} }
  return self.suites:insert(setmetatable(suite, { __index = suite_api }))
end

--#endregion

--#region [module: testing controller]

--
--- ?
--
local controller = {}

--
--- ?
---
--- @param plugin plugin
--- @param event string?
---
--- @return testkit
--
function controller:setup(plugin, event)
  --#region: ?
  -- ???
  --#endregion

  local testkit =
  {
    event = event,
    plugin = plugin,

    suites = list()
  }

  setmetatable(testkit, { __index = testkit_api })

  --#region: ?
  -- ???
  --#endregion

  

  return testkit
end

--
--- ?
---
--- @param result testkit.result
--
function controller:display(result) end

--#endregion

--#region [library: assertions]

--
--- ?
--
local assertion = {}

--
--- ?
---
--- @param actual unknown
--- @param expected unknown
---
--- @return testkit.assertion.result
--
assertion.equal = function(actual, expected)
  ---@diagnostic disable-next-line: missing-return
end

--#endregion

--#region [API: testing framework]

_G.contraption =
{
  assert = assertion,

  ---
  --- ?
  ---
  --- @param plugin plugin
  --- @param event string?
  ---
  testkit = function(plugin, event)
    return controller:setup(plugin, event)
  end
}

--#endregion

--#region (apply read-only restrictions to the testkit API)

setmetatable(contraption,
  {
    __newindex = function()
      throw('Restricted action, the testkit API is protected')
    end,

    __index = function(self, key)
      local value = self[key]
      return (type(value) == 'table' and _table.immutable(value)) or value
    end
  }
)

--#endregion
