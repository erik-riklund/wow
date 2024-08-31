--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            

--- @type string, FrameworkContext
local addon, context = ...

--
-- Establishes the core framework plugin ("cogspinner") as a privileged entity,
-- enabling it to create and utilize private network channels for internal communication.
--

context:export('core/plugin', { id = 'cogspinner' } --[[@as PartialPlugin]])
