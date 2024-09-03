--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

--- @type string, Context
local addonId, context                     = ...

local exception                            = _G.exception
local setmetatable                         = _G.setmetatable
local tostring                             = _G.tostring
local type                                 = _G.type

--
-- This metatable serves as the blueprint for creating record objects,
-- which are similar to maps but with stricter key validation.
--

local record                               =
{
  __index =
  {
    --
    -- Retrieves the value associated with a given key from the record.
    -- Throws an error if the key doesn't exist to prevent unexpected behavior.
    --

    get = function(self, key)
      if self.entries[key] == nil then
        exception('Cannot get value for non-existent key: ' .. tostring(key))
      end

      return self.entries[key]
    end,

    --
    -- Sets or updates the value associated with a key in the record.
    --

    set = function(self, key, value)
      if type(key) ~= 'string' and type(key) ~= 'table' then
        exception('Invalid key type: keys must be either strings or tables.')
      end

      if type(value) == 'nil' then
        exception('Cannot set a "nil" value. Use the remove() method to delete entries.')
      end

      self.entries[key] = value
    end,

    --
    -- Removes a key-value pair from the record based on the given key.
    -- Throws an error if the key doesn't exist to prevent unexpected behavior.
    --

    remove = function(self, key)
      if self.entries[key] == nil then
        exception('Cannot remove non-existent key: ' .. tostring(key))
      end

      self.entries[key] = nil
    end,

    --
    -- Checks if a key exists within the record.
    --

    entryExists = function(self, key)
      return self.entries[key] ~= nil
    end

  } --[[@as Record]]
}

--- @type RecordConstructor
local constructor = function(entries, options)
  if entries and type(entries) ~= 'table' then
    exception('Invalid argument type for "entries". Expected a table (or nil).')
  end

  if options and options.weak then
    --~ Enables "weak mode" for the record's internal table. In weak mode, certain entries
    --~ in the table can be automatically removed by the garbage collector if they are no
    --~ longer referenced elsewhere. This helps prevent memory leaks, especially when
    --~ storing objects (tables) as keys or values within the record.
    
    --~ The 'options.weak' value determines whether keys, values, or both are considered weak.

    local weakMode =
        (options.weak == 'key' and 'k')
        or (options.weak == 'value' and 'v')
        or (options.weak == 'both' and 'kv')
        or exception('Invalid value for "options.weak". Allowed values are "key", "value", or "both".')

    entries = setmetatable(entries or {}, { __mode = weakMode })
  end

  return setmetatable({ entries = entries or {} }, record)
end

--
-- ?
--

context:export('collection/record', constructor)
