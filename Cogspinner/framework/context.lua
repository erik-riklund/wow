--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local _, context = ... ---@cast context core.context

--#region: locally scoped variables
local setmetatable, throw = setmetatable, throw
--#endregion

--#region

--- @type core.context
local __context =
{
  data = {},

  --
  export = function(self, id, object)
    if self.data[id] then
      throw('Unable to overwrite existing export `%s`', id)
    end

    self.data[id] = object
  end,

  --
  import = function(self, id)
    return self.data[id] or throw('Unknown import: `%s`', id)
  end
}

--#endregion

setmetatable(context, { __index = __context })
