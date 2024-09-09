--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            
--
--- @type string, core.context
local addon, framework = ...

--- @type function
local continueProcess = framework.import('callback/continue-process')

---
---
---
--- @type Frame
---
local frame = CreateFrame('Frame', 'CogspinnerFrame')

--
--
--
frame:SetShown(true)

--
--
--
frame:SetScript('OnUpdate', function() continueProcess() end)

--
--
--
framework.export('core/frame', frame)
