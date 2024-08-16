--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local addon, context = ...

--#region: locally scoped variables

--- @cast context { plugin: plugin, tests: testkit }

--
--- ?

local cogspinner = cogspinner
local string = cogspinner.utility.string

--#endregion

--#region [test suite: string.split]

---
--- ?

local split = context.tests:suite('utilities: string.split')

--#endregion
