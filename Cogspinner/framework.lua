--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

-- < ADDON DEVELOPMENT FRAMEWORK >
-- created by Erik Riklund (2024)
--
-- [Add project description here]
--

--#region: locally scoped global variables

local assert, error, ipairs, pairs, type = assert, error, ipairs, pairs, type
local coroutine, string, table = coroutine, string, table

--#endregion

--#region [library: utilities]

--#region [function: throw]

--
--- Raises a formatted error message, optionally using provided values to fill in placeholders
--- within the message string. The error is raised from the caller's context.
--- @param exception string The error message template.
--- @param ... string | number Optional values to insert into the message.
--
local function throw(exception, ...)
  error(... and string.format(exception, ...) or exception, 3)
end

--#endregion

--#region [class: map]

--
--- Provides functionality for creating and manipulating custom map (key-value) objects.
--
local map_controller =
{
  --
  --- @param self map.instance
  --- @param key unknown
  --
  get = function(self, key) return self.data[key] end,

  --
  --- @param self map.instance
  --- @param key unknown
  --- @param value unknown
  --
  set = function(self, key, value) self.data[key] = value end,

  --
  --- @param self map.instance
  --- @param key unknown
  --
  has = function(self, key) return self:get(key) ~= nil end,

  --
  --- @param self map.instance
  --- @param search_value unknown
  --
  contains = function(self, search_value)
    for key, value in pairs(self.data) do
      if value == search_value then return key end
    end
  end
}

--
--- Creates a new map instance, optionally initialized with provided key-value pairs.
---
--- @param initial_content map<unknown, unknown>? (optional) A table of initial key-value pairs for the map.
--- @return map.instance
--
local function map(initial_content)
  initial_content = (type(initial_content) == 'table' and initial_content) or {}
  return setmetatable({ data = initial_content }, { __index = map_controller })
end

--#endregion

--#region [class: list]

--
--- Provides functionality for creating and manipulating custom list objects.
--
local list_controller =
{
  --
  --- @param self list.instance
  --- @param index number
  --
  get = function(self, index) return self.data[index] end,

  --
  --- @param self list.instance
  --- @param value unknown
  --
  contains = function(self, value) return self:indexof(value) ~= -1 end,

  --
  --- @param self list.instance
  --- @param value unknown
  --
  indexof = function(self, value)
    for i, current_value in ipairs(self.data) do
      if current_value == value then return i end
    end

    return -1 -- note: used when the value isn't found.
  end,

  --
  --- @param self list.instance
  --- @param value unknown
  --- @param position number?
  --
  insert = function(self, value, position)
    table.insert(self.data, position or (#self.data + 1), value)
  end
}

--
--- Creates a new list instance, optionally initialized with provided values.
---
--- @param initial_values list<unknown>? (optional) An array of initial values for the list.
--- @return list.instance
--
local function list(initial_values)
  initial_values = (type(initial_values) == 'table' and initial_values) or {}
  return setmetatable({ data = initial_values }, { __index = list_controller })
end

--#endregion

--#region [function: string_split]

--
--- Divides a string into a list of substrings, using a specified separator
--- to determine the boundaries between them. If the separator is not found in
--- the target string, the entire string is returned as a single-element list.
--
--- @param target string
--- @param separator string
--
--- @return list<string>
--
local string_split = function(target, separator)
  assert(
    type(target) == 'string' and type(separator) == 'string',
    "Expected both 'target' and 'separator' to be strings"
  )

  if string.find(target, separator) then
    local result = ({} --[[@as list<string>]])

    for piece in string.gmatch(target, '([^' .. separator .. ']+)') do
      table.insert(result, piece)
    end

    return result
  end

  return { target } -- note: only used when the separator isn't found
end

--#endregion

--#region [function: string_contains]

--
--- ?
--
local string_contains = function() end

--#endregion

--#region [function: table_walk]

--
--- Traverses a nested table (like a directory structure) using a dot-separated path string,
--- returning a reference to the target table if the path is complete or `build_mode` is enabled
--- (which will create missing intermediate tables), otherwise `nil`.
--
--- @param target table
--- @param path string
--- @param options { build_mode: boolean? }?
--
--- @return table?
--
local table_walk = function(target, path, options)
  options = options or { build_mode = false }

  assert(
    type(target) == 'table' and type(path) == 'string',
    "Expected a table for 'target' and a string for 'path'"
  )

  local reference = target
  local heritage = string_split(path, '.')

  local build_mode = type(options.build_mode) == 'boolean' and options.build_mode == true

  --#region: Obtain the reference for the given 'path'
  -- Iterates over the segments of the given `path`, using each segment to navigate
  -- deeper into the `target` table. If a segment is missing in the table and `build_mode`
  -- is true, an empty table is created at that position to continue the traversal.
  --
  -- If `build_mode` is false, the process is aborted when a missing segment is encountered.
  --#endregion

  for _, ancestor in ipairs(heritage) do
    if type(reference[ancestor]) ~= 'table' then
      if not build_mode then
        return nil -- note: cancel the process when not in build mode.
      end

      reference[ancestor] = {}
    end

    reference = reference[ancestor] --[[@as table]]
  end

  return reference
end

--#endregion

--#endregion

--#region [module: event handler]

--
--- ?
--
local event_handler =
{
  --
  --- ?
  --
  listeners = map(),

  --
  --- ?
  --
  frame = CreateFrame('Frame', 'CogspinnerEventFrame')
}

--#endregion

--#region [module: storage handler]

--
--- ?
--
local storage_controller =
{
  --
  --- @param self storage.instance
  --- @param variable string
  --
  get = function(self, variable)
    -- todo: implementation
  end,

  --
  --- @param self storage.instance
  --- @param variable string
  --- @param value unknown
  --
  set = function(self, variable, value)
    local target = self.data

    -- todo: implementation
  end,

  --
  --- @param self storage.instance
  --- @param variable string
  --
  drop = function(self, variable) self:set(variable, nil) end
}

--
--- ?
--
local storage_handler = {}

--
--- ?
--- @param plugin plugin
--- @param options storage.options?
--
function storage_handler:setup(plugin, options)
  -- todo: implementation
end

--#endregion

--#region: plugin API

--
--- ?
--
local plugin_api = {}

--
--- ?
--- @param self plugin
--- @param callback function
--
function plugin_api.onload(self, callback) end

--#endregion

--#region [module: plugin manager]

--
--- ?
--
local plugin_manager = { registry = list() }

--
--- ?
--- @param identifier string
--- @param options plugin.create.options?
--- @return plugin
--
function plugin_manager:create(identifier, options)
  options = options or {}

  if string.match(identifier, '^[a-zA-Z0-9-]+$') == nil then
    throw('Invalid plugin identifier, may only contain `a-z`, `A-Z` and `0-9`')
  end

  if self.registry:contains(identifier) then
    throw('Unable to register plugin with non-unique identifier `%s`', identifier)
  end

  self.registry:insert(identifier)
  local context = setmetatable({ id = identifier }, { __index = plugin_api })

  -- storage module extension:
  if type(options.storage) == 'table' then
    storage_handler:setup(context --[[@as plugin]], options.storage)
  end

  -- todo: other context extensions based on options!

  return context
end

--#endregion

--#region: framework API

-- The API for the Cogspinner framework.
_G.cogspinner =
{
  --- ?
  --- @param identifier string
  --- @param options plugin.create.options
  plugin = function(identifier, options)
    return plugin_manager:create(identifier, options)
  end,

  --- A handy toolbox of helper functions for simplifying routine development tasks.
  utility = {
    throw = throw,
    collection = { list = list, map = map },
    string = { contains = string_contains, split = string_split }
  }
}

--#endregion
