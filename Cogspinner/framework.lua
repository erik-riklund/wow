--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

-- < ADDON DEVELOPMENT FRAMEWORK >
-- created by Erik Riklund (2024)
--
-- ???
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
  end,

  --
  --- @param self map.instance
  --
  size = function(self)
    local count = 0
    for _ in pairs(self.data) do
      count = count + 1
    end

    return count
  end,

  --
  --- @param self map.instance
  --
  values = function(self) return pairs(self.data) end
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
  end,

  --
  --- @param self list.instance
  --- @param position number?
  --
  remove = function(self, position)
    return table.remove(self.data, position or #self.data)
  end,

  --
  --- @param self list.instance
  --
  length = function(self) return #self.data end,

  --
  --- @param self list.instance
  --
  values = function(self) return ipairs(self.data) end
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

--#region [function: table_walk]

--
--- Traverses a nested table (like a directory structure) using a list of path names,
--- returning a reference to the target table if the path is complete or `build_mode`
--- is enabled (which will create missing intermediate tables), otherwise `nil`.
--
--- @param target table
--- @param path list<unknown>
--- @param options { build_mode: boolean? }?
--
--- @return table|nil
--
local table_walk = function(target, path, options)
  assert(
    type(target) == 'table' and type(path) == 'table',
    "Expected tables for 'target' and 'path'"
  )

  local reference = target
  options = options or { build_mode = false }

  --#region: Obtain the reference for the given 'path'
  -- Iterates over the segments of the given `path`, using each segment to navigate
  -- deeper into the `target` table. If a segment is missing in the table and `build_mode`
  -- is true, an empty table is created at that position to continue the traversal.
  --
  -- If `build_mode` is false, the process is aborted when a missing segment is encountered.
  --#endregion

  for i, ancestor in ipairs(path) do
    if not reference[ancestor] then
      if not options.build_mode then
        return nil -- note: cancel the process when not in build mode.
      end

      reference[ancestor] = {}
    end

    if type(reference[ancestor]) ~= 'table' then
      throw('Unexpected non-table value encountered at `%s`', table.concat(path, '.', 1, i))
    end

    reference = reference[ancestor] --[[@as table]]
  end

  return reference
end

--#endregion

--#endregion

--#region: framework resources

--
--- ?
--
local frame = CreateFrame('Frame', 'CogspinnerFrame')

--
--- ?
--
frame:RegisterEvent('ADDON_LOADED')

--#endregion

--#region [module: tasks]

--
--- ?
--
local task_handler = { jobs = list() }

--
--- ?
--
local task_process = coroutine.create(
  function()
    local frame_limit = 0.0166 -- note: 60fps

    while true do
      local start_time = GetTime()

      while task_handler.jobs:length() > 0 and (GetTime() - start_time) < frame_limit do
        local task = task_handler.jobs:remove(1) --[[@as task]]
        local success = pcall(task.callback, unpack(
          (type(task.arguments) == 'table' and task.arguments) or {}
        ))

        if not success then
          -- todo: implement error handling?
        end
      end

      coroutine.yield()
    end
  end
)

--
--- ?
--- @param callback function
--- @param ... unknown
--
function task_handler:queue(callback, ...)
  self.jobs:insert({ callback = callback, arguments = { ... } } --[[@as task]])
end

--
--- ?
--
frame:SetScript('OnUpdate', function()
  if coroutine.status(task_process) == 'suspended' then
    if task_handler.jobs:length() > 0 then coroutine.resume(task_process) end
  end
end)

--#endregion

--#region [module: events]

--
--- ?
--
local event_handler = { listeners = map() }

--
--- ?
--
event_handler.listeners:set('ADDON_LOADED', map())

--
--- ?
--- @param plugin_id string
--- @param options event.listener.options
--
function event_handler:listen(plugin_id, options)
  if not self.listeners:has(options.event) then
    frame:RegisterEvent(options.event)
    self.listeners:set(options.event, list())
  end

  if options.event == 'ADDON_LOADED' then
    local plugins = self.listeners:get('ADDON_LOADED') --[[@as map.instance]]
    if not plugins:has(plugin_id) then plugins:set(plugin_id, list()) end

    local plugin_listeners = plugins:get(plugin_id) --[[@as list.instance]]

    plugin_listeners:insert(
      { plugin_id = plugin_id, callback = options.callback, trigger = 'once' } --[[@as event.listener]]
    )
  else
    local listeners = self.listeners:get(options.event) --[[@as list.instance]]

    listeners:insert(
      {
        plugin_id = plugin_id,
        callback = options.callback,
        callback_id = options.callback_id,
        trigger = options.trigger
      } --[[@as event.listener]]
    )
  end
end

--
--- ?
--- @param event string
--- @param plugin_id string
--- @param callback_id string?
--
function event_handler:silence(event, plugin_id, callback_id)
  if event ~= 'ADDON_LOADED' and self.listeners:has(event) then

  end
end

--
--- ?
--
frame:SetScript('OnEvent',
  function(self, event, ...)
    if event == 'ADDON_LOADED' then
      --#region: ?
      -- ?
      --#endregion

      local addon_id = ...
      local plugins = event_handler.listeners:get('ADDON_LOADED') --[[@as map.instance]]

      if plugins:has(addon_id) then
        local listeners = plugins:get(addon_id) --[[@as list.instance]]

        for _, listener in listeners:values() do
          --- @cast listener event.listener
          task_handler:queue(listener.callback)
        end

        plugins:set(addon_id, nil)
      end
    else
      --#region: ?
      -- ?
      --#endregion

      -- todo: implementation...
    end
  end
)

--#endregion

--#region [module: storage]

--
--- Provides methods for managing and accessing saved variables.
--
local storage_controller =
{
  --
  --- @param self storage.instance
  --- @param variable_path string
  --- @return unknown
  --
  get = function(self, variable_path)
    local target, variable = self:resolve(variable_path, false)
    return (type(target) == 'table' and target[variable]) or nil
  end,

  --
  --- @param self storage.instance
  --- @param variable_path string
  --- @param value unknown
  --
  set = function(self, variable_path, value)
    local target, variable = self:resolve(variable_path, true)
    target[variable] = value
  end,

  --
  --- @param self storage.instance
  --- @param variable_path string
  --
  drop = function(self, variable_path)
    local target, variable = self:resolve(variable_path, false)
    if type(target) == 'table' then target[variable] = nil end
  end,

  --
  --- @private
  --- @param self storage.instance
  --- @param variable_path string
  --- @param build_mode boolean
  --- @return table|nil, string
  --
  resolve = function(self, variable_path, build_mode)
    local target = self.data --[[@as table|nil]]
    local variable = variable_path

    if string.find(variable_path, '.') then
      local ancestors = string_split(variable_path, '.')
      variable = table.remove(ancestors) --[[@as string]]

      target = table_walk(target --[[@as table]], ancestors, { build_mode = build_mode })
    end

    return target, variable
  end
}

--
--- A module that sets up and configures storage for plugins.
--
local storage_handler = {}

--
--- Sets up storage for a plugin based on the provided options.
---
--- @param plugin plugin The plugin for which storage should be set up.
--- @param options storage.options? (optional) Configuration options for storage.
--
function storage_handler:setup(plugin, options)
  options = (type(options) == 'table' and options) or {}

  plugin:onload(
    function()
      for _, level in ipairs({ 'account', 'character' }) do
        if options[level] then
          --#region: Plugin storage initialization
          -- Load the saved variables, as specified in the options, and assign a
          -- storage controller to each of the variables (account and character).
          --#endregion

          local variable = string.format('__%s_%s', plugin.id, level)
          _G[variable] = _G[variable] or {}

          plugin.data[level] = setmetatable(
            { data = _G[variable] }, { __index = storage_controller }
          )
        end
      end
    end
  )
end

--#endregion

--#region: plugin API

--
--- ?
--
local plugin_api = {}

--
--- @param self plugin
--- @param callback function
--
function plugin_api.onload(self, callback)
  self:listen({ event = 'ADDON_LOADED', callback = callback, trigger = 'once' })
end

--
--- @param self plugin
--- @param options event.listener.options
--
function plugin_api.listen(self, options)
  event_handler:listen(self.id, options)
end

--
--- @param self plugin
--- @param event WowEvent
--- @param callback_id string?
--
function plugin_api.silence(self, event, callback_id)
  event_handler:silence(event, self.id, callback_id)
end

--#endregion

--#region [module: plugins]

--
--- ?
--
local plugin_manager = { registry = list() }

--
--- ?
--- @param identifier string
--- @param options plugin.options?
--- @return plugin
--
function plugin_manager:create(identifier, options)
  options = (type(options) == 'table' and options) or {}

  --#region: ?
  -- ???
  --#endregion

  if string.match(identifier, '^[a-zA-Z0-9_]+$') == nil then
    throw('Invalid plugin identifier, may only contain underscores, letters (`a-z`, `A-Z`) and numbers.')
  end

  if self.registry:contains(identifier) then
    throw('Unable to register plugin with non-unique identifier `%s`', identifier)
  end

  self.registry:insert(identifier)
  local context = setmetatable({ id = identifier }, { __index = plugin_api })

  --#region: ?
  -- ???
  --#endregion

  if type(options.storage) == 'table' then
    storage_handler:setup(context, options.storage)
  end

  return context
end

--#endregion

--#region: framework API

-- The API for the Cogspinner framework.
_G.cogspinner =
{
  --- ?
  --- @param identifier string
  --- @param options plugin.options
  plugin = function(identifier, options)
    return plugin_manager:create(identifier, options)
  end,

  --- A handy toolbox of helper functions for simplifying routine development tasks.
  utility =
  {
    throw = throw,

    collection = { list = list, map = map },
    string = { split = string_split },
    table = { walk = table_walk }
  }
}

--#endregion
