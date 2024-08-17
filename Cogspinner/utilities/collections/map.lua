--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local addon, context = ... ---@cast context core.context

--#region: locally scoped variables

local pairs, setmetatable, throw, type =
    pairs, setmetatable, throw, type

--#endregion

--#region [metatable: __map]

---@type map
local __map =
{
  entries = 0,
  content = {},

  --
  get = function(self, key)
    return self.content[key]
  end,

  --
  set = function(self, key, value)
    if value == nil then
      self:drop(key)
      return
    end

    if self.content[key] == nil then
      self.entries = self.entries + 1
    end

    self.content[key] = value
  end,

  --
  drop = function(self, key)
    if self.content[key] ~= nil then
      self.content[key] = nil
      self.entries = self.entries - 1
    end
  end,

  --
  has = function(self, key)
    return self.content[key] ~= nil
  end,

  --
  size = function(self)
    return self.entries
  end
}

--#endregion

--#region [function: map]

---@type utilities.collections.map
local function map(initial_content)
  local object = {

  }

  return setmetatable(object, { __index = __map })
end

--#endregion

context:export('utilities.collections.map', map)
