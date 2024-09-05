--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string, Context
local addon, framework     = ...

local createPlugin         = framework.import('module/plugin') --[[@as PluginConstructor]]
local createImmutableProxy = framework.import('table/immutable') --[[@as ImmutableTableProxy]]

--
-- ?
--
--- @type API
--
_G.cogspinner              = createImmutableProxy(
  {
    --
    -- ?
    --
    createPlugin = function(name)
      return createPlugin(name)
    end,

  } --[[@as API]]
)
