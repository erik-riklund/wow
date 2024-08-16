--    ____                      _                       
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __ 
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |   
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|   
--              |___/    |_|                            

local addon, context = ...

--#region: locally scoped variables

local cogspinner = cogspinner
local utility = cogspinner.utility

local _table, throw = utility.table, utility.throw

--#endregion

--#region [API: user interface assembler]

--
--- ?
--
_G.assembler =
{
  --
  --- ?
  --
  panel = function() end,
  
  --
  --- ?
  --
  window = function() end
}

--#endregion

--#region (apply read-only restrictions to the assembler API)

setmetatable(assembler,
  {
    __newindex = function()
      throw('Restricted action, the assembler API is protected')
    end,

    __index = function(self, key)
      local value = self[key]
      return (type(value) == 'table' and _table.immutable(value)) or value
    end
  }
)

--#endregion
