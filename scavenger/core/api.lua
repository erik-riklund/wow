--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
--   github.com/erik-riklund/wow/scavenger/core (2026)

---@class context
local x = select(2, ...)

---------------------------------------------------------------------
-- ?

x.api = {
  -- ?
  extend = function(key, callback)
    if x.api[key] ~= nil then
      -- todo > print a warning
    elseif type(callback) ~= "function" then
      -- todo > print a warning
    else
      x.api[key] = callback -- ?
    end
  end
}

---------------------------------------------------------------------
-- ?

_G.Scavenger = setmetatable(
  {}, {
    -- ?
    __index = function(_, key)
      if x.api[key] == nil then
        -- todo > print a warning
      else
        return x.api[key] -- ?
      end
    end,

    --?
    __newindex = function()
      -- todo > print a warning
    end
  }
)
