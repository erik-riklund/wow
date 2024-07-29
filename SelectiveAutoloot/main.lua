-- https://github.com/erik-riklund/wow/tree/master/SelectiveAutoloot

--    _____      _           _   _
--   / ____|    | |         | | (_)
--  | (___   ___| | ___  ___| |_ ___   _____
--   \___ \ / _ \ |/ _ \/ __| __| \ \ / / _ \
--   ____) |  __/ |  __/ (__| |_| |\ V /  __/
--  |_____/ \___|_|\___|\___|\__|_| \_/ \___|
--     /\        | |      | |           | |
--    /  \  _   _| |_ ___ | | ___   ___ | |_
--   / /\ \| | | | __/ _ \| |/ _ \ / _ \| __|
--  / ____ \ |_| | || (_) | | (_) | (_) | |_
-- /_/    \_\__,_|\__\___/|_|\___/ \___/ \__|
--
--         by Erik Riklund (2024) v2.0

--#region: local variables

local config = {}
local player = {}
local transmog = C_TransmogCollection

--#endregion

--#region: default configuration

--- @type autoloot.config
local defaultConfig = {
  GOLD_MAX = 50,
  JUNK_ALL = false,
  JUNK_MIN_VALUE = 0,
  JUNK_MAX_VALUE = 99999,
  QUEST_ALL = false
}

--#endregion

--#region (initialization)

local frame = CreateFrame(
  'Frame', 'selective-autoloot'
)

frame:SetShown(false)
frame:RegisterEvent('PLAYER_LOGIN')
frame:RegisterEvent('LOOT_READY')
frame:RegisterEvent('LOOT_OPENED')
frame:RegisterEvent('LOOT_CLOSED')

frame:SetScript('OnEvent',
  function(self, event, ...) pcall(event, ...) end
)

SetCVar('autoLootDefault', 0)

--#endregion

--#region [function: getConfigValue]

--- comment
--- @param key autoloot.configKey
--- @return string | number | boolean
local function getConfigValue(key)
  return (config[key] ~= nil and config[key]) or defaultConfig[key]
end

--#endregion

--#region [function: ADDON_LOADED]

--- ?
--- @param name string
--- @diagnostic disable-next-line: unused-function, unused-local
local function ADDON_LOADED(name)
  if name == 'SelectiveAutoloot' then
    if _G.SelectiveAutolootConfig == nil then
      _G.SelectiveAutolootConfig = defaultConfig
    end
    
    config = _G.SelectiveAutolootConfig
  end
end

--#endregion

--#region [function: PLAYER_LOGIN]

--- ?
--- @diagnostic disable-next-line: unused-function, unused-local
local function PLAYER_LOGIN()
  player.class = UnitClass('player')[3] --[[@as number]]
end

--#endregion

--#region [function: LOOT_READY]

--- ?
--- @param autoloot boolean
--- @diagnostic disable-next-line: unused-function, unused-local
local function LOOT_READY(autoloot)
end

--#endregion

--#region [function: LOOT_OPENED]

--- ?
--- @param autoloot boolean
--- @param isFromItem boolean
--- @diagnostic disable-next-line: unused-function, unused-local
local function LOOT_OPENED(autoloot, isFromItem)
end

--#endregion

--#region [function: LOOT_CLOSED]

--- ?
--- @diagnostic disable-next-line: unused-function, unused-local
local function LOOT_CLOSED()
end

--#endregion
