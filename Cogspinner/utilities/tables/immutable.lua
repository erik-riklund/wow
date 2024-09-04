--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string, Context
local addon, framework = ...

local exception        = _G.exception
local setmetatable     = _G.setmetatable
local type             = _G.type

local record           = framework.import('collection/record') --[[@as RecordConstructor]]

--- @type Table.ImmutableProxy
local createImmutableProxy

--
-- Stores immutable proxies for processed tables, using weak values to allow the garbage
-- collector to reclaim unreferenced proxies, thereby preventing potential memory leaks.
--

local proxyCache       = record(nil, { weak = 'value' })

--
-- Creates and caches a read-only proxy for a table, eliminating
-- redundant proxy creation and enhancing performance.
--

createImmutableProxy   = function(target)
  if type(target) ~= 'table' then
    exception('Invalid argument type. Expected a table, recieved `%s`.', type(target))
  end

  if not proxyCache:entryExists(target) then
    local proxy =
    {
      __newindex = function()
        exception('Attempt to modify a read-only table.')
      end,

      __index = function(self, key)
        local value = target[key]

        return (type(value) == 'table' and createImmutableProxy(value)) or value
      end
    }

    proxyCache:set(target, setmetatable({}, proxy))
  end

  return proxyCache:get(target)
end

--
-- Export the function to the framework context.
--

framework.export('table/immutable', createImmutableProxy)
