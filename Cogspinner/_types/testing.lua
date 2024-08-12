--- @meta

--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--#region (type: test.plan)

--
--- ?
---
--- @class test.plan
---
--- @field context plugin
--- @field suites map
---
--- @field suite fun(self: test.plan, label: string): test.suite
--

--#endregion

--#region (type: test.suite)

--
--- ?
---
--- @class test.suite
---
--- @field tests list
--- @field test fun(self: test.suite, options: test.options)
--

--#endregion

--#region (type: test.options)

--
--- ?
---
--- @class test.options
--

--#endregion
