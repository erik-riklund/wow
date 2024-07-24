--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|


--#region: locally scoped global variables



--#endregion

--#region [library: utilities] @ version 1.0.0

--#region [class: list]

local list = {}

--#endregion

--#region [class: map]

local map = {}

--#endregion

--#endregion

--#region [core module: task processor] @ version 1.0.0

local task = {}

--#endregion

--#region [module: exchange manager] @ version 1.0.0

local exchange = {}

--#endregion

--#region [module: service manager] @ version 1.0.0

local service = {}

--#endregion

--#region [module: event handler] @ version 1.0.0

local event = {}

--#endregion

--#region [module: channel manager] @ version 1.0.0

local channel = {}

--#endregion

--#region [module: data store] @ version 1.0.0

local store = {}

--#endregion

--#region [module: locale manager] @ version 1.0.0

local locale = {}

--#endregion

--#region [module: tooltip controller] @ version 1.0.0
--#endregion

--#region: plugin API @ version 1.0.0

local plugin_api = {}

--#endregion

--#region [module: plugin manager] @ version 1.0.0

local plugin = { registry = list.new() }

-- ?
--- @param identifier string
--- @return plugin
function plugin:create(identifier)
  local context = ({ id = identifier } --[[@as plugin]])
  -- todo: send plugin creation broadcast through the channel network!
  return setmetatable(context, { __index = plugin_api })
end

--#endregion

--#region: framework API @ version 1.0.0

-- The API for the Cogspinner framework.
_G.cogspinner =
{
  -- A handy toolbox of helper functions for
  -- simplifying routine development tasks.
  utility = {
    collection = { list = list, map = map }
  },

  -- ?
  --- @param identifier string
  create_plugin = function(identifier) return plugin:create(identifier) end
}

--#endregion
