--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

-- ADDON DEVELOPMENT FRAMEWORK
-- created by Erik Riklund (2024)
--
-- [Add project description here]
--

--#region: locally scoped global variables

local assert, error, ipairs, pairs, type = assert, error, ipairs, pairs, type
local coroutine, string, table = coroutine, string, table

--#endregion

--#region [library: utilities]

--#region [function: throw] @ version 1.0.0

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

--#region [class: map] @ version 1.0.0

--
--- ?
--
local map_controller = {
  has = function(key) end,
  contains = function(value) end
}

--
--- ?
--- @param initial_content map<unknown, unknown>?
--- @return map_instance
--
local function map(initial_content)
  initial_content = type(initial_content) == 'table' and initial_content or {}
  return setmetatable({ data = initial_content }, { __index = map_controller })
end

--#endregion

--#region [class: list] @ version 1.0.0

--
--- Provides functionality for creating and manipulating custom list objects.
--
local list_controller =
{
  --
  --- @param self list_instance
  --- @param index number
  --
  get = function(self, index) return self.data[index] end,

  --
  --- @param self list_instance
  --- @param value unknown
  --
  contains = function(self, value) return self:indexof(value) ~= -1 end,

  --
  --- @param self list_instance
  --- @param value unknown
  --
  indexof = function(self, value)
    for i, current_value in ipairs(self.data) do
      if current_value == value then return i end
    end

    return -1 -- note: used when the value isn't found.
  end,

  --
  --- @param self list_instance
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
--- @return list_instance
--
local function list(initial_values)
  initial_values = type(initial_values) == 'table' and initial_values or {}
  return setmetatable({ data = initial_values }, { __index = list_controller })
end

--#endregion

--#region [function: string_split] @ version 1.0.0

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

--#region [function: table_walk] @ version 1.0.0

--
--- Traverses a nested table (like a directory structure) using a dot-separated path string,
--- returning a reference to the target table if the path is complete or `build_mode` is enabled
--- (which will create missing intermediate tables), otherwise `nil`.
--
--- @param target table
--- @param path string
--- @param build_mode? boolean
--
--- @return table?
--
local table_walk = function(target, path, build_mode)
  assert(
    type(target) == 'table' and type(path) == 'string',
    "Expected a table for 'target' and a string for 'path'"
  )

  local reference = target
  local heritage = string_split(path, '.')

  build_mode = type(build_mode) == 'boolean' and build_mode == true

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

--
--- ?
--
local store = {}

--
--- ?
--
local storage = {}

--#endregion

--#region [module: locale manager] @ version 1.0.0

local locale = {}

--#endregion

--#region [module: tooltip controller] @ version 1.0.0
--#endregion

--#region: plugin API @ version 1.0.0

--
--- ?
--
local plugin_api = {}

--#endregion

--#region [module: plugin manager] @ version 1.0.0

--
--- ?
--
local plugin = {
  -- ?
  registry = list()
}

--
--- ?
--- @param identifier string
--- @return plugin
--
function plugin:create(identifier)
  if self.registry:contains(identifier) then
    throw('Unable to register plugin with non-unique identifier `%s`', identifier)
  end

  self.registry:insert(identifier)
  local context = setmetatable(
    { id = identifier }, { __index = plugin_api }
  )

  -- todo: broadcast through the channel system?

  return context
end

--#endregion

--#region: framework API @ version 1.0.0

-- The API for the Cogspinner framework.
_G.cogspinner =
{
  -- ?
  --- @param identifier string
  plugin = function(identifier) return plugin:create(identifier) end,

  -- A handy toolbox of helper functions for simplifying routine development tasks.
  utility = {
    throw = throw, collection = { list = list, map = map }
  }
}

--#endregion
