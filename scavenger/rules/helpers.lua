--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger/rules (2026)

--- @class context
local x = select(2, ...)

--
-- # Currency conversion helper
--
-- Converts a structural money table consisting of gold, silver, and copper
-- segments into a single unified value expressed entirely in copper pieces.
--

x.to_copper = function(amount)
  local gold = amount.gold or 0
  local silver = amount.silver or 0
  local copper = amount.copper or 0

  return copper + (silver * 100) + (gold * 10000)
end
