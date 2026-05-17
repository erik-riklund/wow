--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger/core (2026)

---@class context
local x = select(2, ...)

--
-- # ?
--
-- ...
--

local registry = {}

--
-- # ?
--
-- ...
--

scavenger.extend(
  "register_settings", function(module, settings)
    if registry[module] == nil then
      registry[module] = {}
    end

    for key, value in pairs(settings) do
      if registry[module][key] ~= nil then
        scavenger.warn(
          "Setting '%s/%s' already exists, use 'scavenger.override_setting'", module, key
        )
      else
        registry[module][key] = value
      end
    end
  end
)

--
-- # ?
--
-- ...
--

scavenger.extend(
  "override_setting", function(path, value)
    -- ?
  end
)

--
-- # ?
--
-- ...
--

scavenger.extend(
  "get_setting", function(path)
    -- todo > ?
  end
)
