--
--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, framework
local addon, framework = ...

---
--- @type Frame
---
local frame = CreateFrame('Frame', 'CogspinnerFrame')

--
-- Ensure the frame is visible to be able to utilize the `OnUpdate` mechanism.
--
frame:SetShown(true)

--
framework.export('core/frame', frame)
