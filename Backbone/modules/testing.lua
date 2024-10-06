--[[~ Module: Testing ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

]]

---
--- ?
---
local testkit = {}

---
--- ?
---
backbone.getTestkit = function() return testkit end

---
--- ?
---
---@param name string
---@param suites TestSuite[]
---
testkit.createGroup = function(name, suites) end

---
--- ?
---
---@param name string
---@param tests Test[]
---
---@return TestSuite
---
testkit.createSuite = function(name, tests)
  ---@diagnostic disable-next-line: missing-return
end

---
--- ?
---
---@param name string
---@param callback function
---
---@return Test
---
testkit.createTest = function(name, callback)
  ---@diagnostic disable-next-line: missing-return
end

---
--- ?
---
---@param first unknown
---@param second unknown
---
testkit.assertEqual = function(first, second) end

---
--- ?
---
---@param first unknown
---@param second unknown
---
testkit.assertNotEqual = function(first, second) end

---
--- ?
---
---@param condition boolean
---
testkit.assertTrue = function(condition) end

---
--- ?
---
---@param condition boolean
---
testkit.assertFalse = function(condition) end

---
--- ?
---
---@param callback function
---
testkit.assertError = function(callback) end

---
--- ?
---
---@param callback function
---
testkit.assertNoError = function(callback) end
