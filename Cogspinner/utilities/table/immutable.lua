--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string, Context
local designation, core = ...

--#region (locally scoped variables/functions)

local setmetatable      = _G.setmetatable
local throw             = _G.throw
local type              = _G.type

--#endregion

--
-- This clever contraption creates a special kinda table, one that's locked tight!
-- It's perfect for keepin' important blueprints and schematics safe from accidental tinkering.
--

--- @type ImmutableTable
local createImmutableProxy

createImmutableProxy    = function(target)
  if type(target) ~= 'table' then
    throw('Invalid argument type for "immutable". Expected a table.')
  end

  --- @type ImmutableTableProxy
  local immutableProxy =
  {
    --
    -- This bit o' magic stops any gnome from tryin' to change somethin' in our locked table.
    -- If they try, it'll set off an alarm!
    --

    __newindex = function()
      throw('Attempt to modify a read-only table.')
    end,

    --
    -- This part makes sure that even if there's a whole bunch of nested tables inside,
    -- they all get locked up tight too! No sneaky changes allowed!
    --

    __index = function(self, key)
      local value = target[key]

      return (type(value) == 'table' and createImmutableProxy(value)) or value
    end
  }

  return setmetatable({}, immutableProxy)
end

--
-- Now, let's share this handy invention with the rest of the workshop,
-- so everyone can use it to protect their precious designs!
--

core:export('table/immutable', createImmutableProxy)
