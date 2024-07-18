--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--#region: locally scoped global variables
-- ?



--#endregion

--#region: framework resources

-- ?
local frame = CreateFrame("Frame")

--#endregion

--#region [module: task handler] @ version 1.0.0

local task_handler = {}

-- ?
task_handler.queue = {}

-- ?
frame:SetScript('OnUpdate', function() end)

--#endregion

--#region [module: event handler] @ version 1.0.0

local event_handler = {}

--#endregion

--#region [module: plugin manager] @ version 1.0.0

local plugin_manager = {}

--- ?
--- @param id string
--- @return plugin.context
function plugin_manager:create_context(id)
  local context = ({ id = id } --[[@as plugin.context]])
  return context
end

--#endregion

--#region: API @ version 1.0.0

--- The API for the Cogspinner framework.
_G.cogspinner =
{
  --- ?
  --- @param id string A unique identifier for the plugin.
  --- @return plugin.context
  create_plugin = function(id)
    return plugin_manager:create_context(id)
  end
}

--#endregion
