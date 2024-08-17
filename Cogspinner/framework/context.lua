--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local addon, context = ...
local setmetatable = setmetatable

--#region [metatable: context]

--
--- ?
---
--- @type framework.context
--
local __context =
{
  --
  --- ?
  --
  data = {},

  --
  --- ?
  --
  import = function(self, id)
    return self.data[id] or throw('Import error - unknown id `%s`', id)
  end,

  --
  --- ?
  --
  export = function(self, id, object)
    
  end
}

--#endregion

setmetatable(context, { __index = __context })
