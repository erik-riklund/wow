--- @meta

--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            

--#region (type: locale.data)

--- @class locale.data
---
--- @field plugin string
--- @field locale string
--- @field default boolean?
--- @field content record<string, string>

--#endregion

--#region (type: locale.api)

--- @class locale.api
--- 
--- @field context plugin
--- @field get fun(self: locale.api, key: string): string

--#endregion
