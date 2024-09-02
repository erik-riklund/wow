--- @meta
--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--
--- @class Context
---
--- @field objects? Record<string, unknown>
--- @field export fun(self: Context, identifier: string, object: unknown)
--- @field import fun(self: Context, identifier: string): unknown
--

-- ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~

--
--- Transforms a given table into a framework context, enabling it to store and share objects.
--- 
--- @alias ContextConstructor fun(target: table)
--
