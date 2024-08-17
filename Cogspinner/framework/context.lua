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
--- Provides basic import/export functionality to the
--- framework context to enable code splitting.
---
--- @type framework.context
--
local __context =
{
  --
  --- A dictionary to store exported objects,
  --- accessible via the 'import' method.
  --
  data = {},

  --
  --- Retrieves an exported object from the context's
  --- data store using its unique identifier.
  --
  import = function(self, id)
    if not self.data[id] then
      throw('Import error - unknown id `%s`', id)
    end

    return self.data[id]
  end,

  --
  --- Exports an object to the context's data store,
  --- making it available for import by other modules.
  --
  export = function(self, id, object)
    if self.data[id] then
      throw('Export error - non-unique id `%s`', id)
    end

    self.data[id] = object
  end
}

--#endregion

setmetatable(context, { __index = __context })
