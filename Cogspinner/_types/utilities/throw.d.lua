--- @meta

--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            

---
--- Raises a formatted error message, optionally using provided values to fill in placeholders
--- within the message string. The error is raised from the caller's context.
--- 
--- @alias utility.throw fun(exception: string, ...: string|number)
--- 
