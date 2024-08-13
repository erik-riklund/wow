--- @meta

--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--#region (type: testing.plan)

--
--- ?
---
--- @class testing.plan
---
--- @field context plugin
--- @field suites map
---
--- @field suite fun(self: testing.plan, label: string): testing.suite
--

--#endregion

--#region (type: testing.suite)

--
--- ?
---
--- @class testing.suite
---
--- @field tests list
--- @field test fun(self: testing.suite, options: testing.test.options)
--

--#endregion

--#region (type: testing.test.options)

--
--- ?
---
--- @class testing.test.options
--

--#endregion
