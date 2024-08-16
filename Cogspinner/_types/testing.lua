--- @meta

--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--#region (type: testkit)

--
--- ?
--- 
--- @class testkit
--- 
--- @field plugin plugin
--- @field event string
--- @field suites list
--- 
--- @field suite fun(self: testkit, label: string): testkit.suite
--

--#endregion

--#region (type: testkit.result)

--
--- ?
--- 
--- @class testkit.result
--- 
--- @field executed number
--- @field passed number
--

--#endregion

--#region (type: testkit.suite)

--
--- ?
--- 
--- @class testkit.suite
--- 
--- @field label string
--- @field context table
--- @field tests list
--- 
--- @field test fun(self: testkit.suite, test: testkit.test)
--- 
--- @field setup? fun(self: testkit.suite)
--- @field teardown? fun(self: testkit.suite)
--

--#endregion

--#region (type: testkit.suite_result)

--
--- ?
--- 
--- @class testkit.suite.result
--

--#endregion

--#region (type: testkit.test)

--
--- ?
--- 
--- @class testkit.test
--- 
--- @field label string
--- @field callback fun()
--

--#endregion

--#region (type: testkit.test_result)

--
--- ?
--- 
--- @class testkit.test.result
--

--#endregion

--#region (type: testkit.assertion_result)

--
--- Encapsulates the result of a test assertion, indicating whether
--- it passed or failed and providing an optional message.
---
--- @class testkit.assertion.result
---
--- @field passed boolean Whether the assertion passed (true) or failed (false).
--- @field message string? An optional message providing details about the assertion result.
--

--#endregion
