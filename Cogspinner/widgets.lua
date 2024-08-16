--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local addon, context = ...

--#region: locally scoped variables

local CreateFrame = CreateFrame

local cogspinner = cogspinner
local utility = cogspinner.utility
local map = utility.collection.map
local _table, throw = utility.table, utility.throw

--#endregion

--#region [module: widget factory]

--
--- ?
--
local widget_factory = {}

-- note: will contain methods for creating different widget types

--#endregion

--#region [module: widget manager]

--
--- ?
--
local widget_manager = {}

--
--- ?
--
widget_manager.pool = map()

--
--- ?
--
function widget_manager:create_widget(options) end

--
--- ?
--
function widget_manager:recycle(widget) end

--#endregion

--#region [API: widget manager]

_G.gizmo =
{
  --
  --- ?
  --
  widget = function(options)
    return widget_manager:create_widget(options)
  end,

  --
  --- ?
  --
  recycle = function(widget)
    widget_manager:recycle(widget)
  end
}

--#endregion

--#region (apply read-only restrictions to the widget factory API)

setmetatable(gizmo,
  {
    __newindex = function()
      throw('Restricted action, the widget factory API is protected')
    end,

    __index = function(self, key)
      local value = self[key]
      return (type(value) == 'table' and _table.immutable(value)) or value
    end
  }
)

--#endregion
