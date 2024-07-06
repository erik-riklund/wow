--
--      #
--     # #   #    #  ####  #    # ###### #    # #####
--    #   #  #    # #    # ##  ## #      ##   #   #
--   #     # #    # #      # ## # #####  # #  #   #
--   ####### #    # #  ### #    # #      #  # #   #
--   #     # #    # #    # #    # #      #   ##   #
--   #     #  ####   ####  #    # ###### #    #   #
--
-- World of Warcraft addon framework, created by Erik Riklund (2024)
--

--#region: locally scoped global variables
-- Doing this both optimizes the usage of the functions, as we only need a
-- single lookup for each function, and it allows the minifier to mangle them,
-- potentially reducing the size of the distributed bundle.

local _assert, _coroutine, _error, _ipairs, _next, _pairs, _rawget, _string, _table, _type, _unpack =
    assert, coroutine, error, ipairs, next, pairs, rawget, string, table, type, unpack
--#endregion

--#region (utility functions)

--#region [function: exception] @ version 1.0.0

--
--- Raises a formatted error message, optionally using provided values to
--- fill in placeholders within the message string.
--
--- @param message string
--- @param ... string | number
--
local exception = function(message, ...)
  _error(... and _string.format(message, ...) or message, 2)
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
  _assert(
    _type(target) == 'string' and _type(separator) == 'string',
    "Expected both 'target' and 'separator' to be strings"
  )

  if _string.find(target, separator) then
    local result = ({} --[[@as list<string>]])

    for piece in _string.gmatch(target, '([^' .. separator .. ']+)') do
      _table.insert(result, piece)
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
--- @return table | nil
--
local table_walk = function(target, path, build_mode)
  _assert(
    _type(target) == 'table' and _type(path) == 'string',
    "Expected a table for 'target' and a string for 'path'"
  )

  local reference = target
  local heritage = string_split(path, '.')

  build_mode = _type(build_mode) == 'boolean' and build_mode == true

  --#region: Obtain the reference for the given 'path'
  -- Iterates over the segments of the given `path`, using each segment to navigate
  -- deeper into the `target` table. If a segment is missing in the table and `build_mode`
  -- is true, an empty table is created at that position to continue the traversal.
  --
  -- If `build_mode` is false, the process is aborted when a missing segment is encountered.
  --#endregion
  for _, ancestor in _ipairs(heritage) do
    if _type(reference[ancestor]) ~= 'table' then
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

--#region [function: table_readonly] @ version 1.0.0

--- @type table
local immutable_table

--
--- Transforms a regular Lua table into a read-only table, preventing any modifications
--- to its contents or nested tables. Any attempt to modify the table or its nested values
--- will raise an error.
--
--- @param target table
--- @return table
--
local table_readonly = function(target)
  _assert(_type(target) == 'table', "Expected a table for 'target'")
  return setmetatable(target, immutable_table)
end

immutable_table = {
  __newindex = function()
    _error('Attempt to modify readonly table', 2)
  end,

  __index = function(table, key)
    local value = _rawget(table, key)
    return _type(value) == 'table' and table_readonly(value --[[@as table]]) or value
  end
}

--#endregion

--#endregion

--#region [module: package system] @ version 1.0.0

--
--- Responsible for managing the import and export of code packages within the system.
--
local warehouse = {}

--
--- Stores the exported packages, indexed by their names.
--
--- @private
--- @type dictionary<string, object>
--
warehouse._crates = {}

--#region (import) @ revision 2024-06-08

--
--- Returns one or more specified packages from the package repository.
--
--- @param ... string
--- @return ...
--
function warehouse:import(...)
  local imports = ({} --[[@as list<object>]])

  for _, package in _ipairs({ ... }) do
    _table.insert(imports, self:_load(package or ''))
  end

  return _unpack(imports)
end

--#endregion

--#region (export) @ revision 2024-06-08

--
--- Export a package with the specified name to the package repository.
--
--- @param package string
--- @param content object
--
function warehouse:export(package, content)
  if self._crates[package] ~= nil then
    return exception("Export failed, the package '%s' already exists", package)
  end

  self._crates[package] = content
end

--#endregion

--#region (_load) @ revision 2024-06-08

--
--- Retrieves a specific package's content from the internal repository.
--
--- @private
--- @param package string
--- @return unknown
--
function warehouse:_load(package)
  return self._crates[package] or exception("Import failed, unknown package '%s'", package)
end

--#endregion

--#endregion

--#region [module: background tasks] @ version 1.0.0

--
--- Responsible for managing and executing tasks.
--
local taskmanager = {}

--
--- The list of tasks awaiting execution.
--
--- @private
--- @type list<task>
--
taskmanager._chores = {}

--
--- Coroutine that handles the execution of tasks from the queue.
--
--- @private
--- @type thread
--
taskmanager._process = nil

--#region (queue) @ revision 2024-06-09

--
--- Adds a new task to the execution queue.
--
--- @param callback function
--
function taskmanager:queue(callback, ...)
  if self._process == nil then self:_setup() end

  if _type(callback) == 'function' then
    _table.insert(self._chores, { callback = callback, arguments = { ... } } --[[@as task]])
    if _coroutine.status(self._process) == 'suspended' then _coroutine.resume(self._process) end
  end
end

--#endregion

--#region (_execute) @ revision 2024-06-09

--
--- Executes a single task by calling its callback function with the provided arguments.
--
--- @private
--- @param task task
--
function taskmanager:_execute(task)
  local success, result = pcall(task.callback, _unpack(task.arguments))
  if not success then --[[todo: implement warnings!]] end
end

--#endregion

--#region (_setup) @ revision 2024-06-09

--
--- Initializes the coroutine responsible for processing tasks in the queue.
--
--- @private
--
function taskmanager:_setup()
  if self._process == nil then
    self._process = _coroutine.create(
      function()
        while true do
          while #self._chores > 0 do
            self:_execute(_table.remove(self._chores, 1) --[[@as task]])
          end

          _coroutine.yield()
        end
      end
    )
  end
end

--#endregion

--#endregion

--#region [module: game events] @ version 1.0.0

--
--- Responsible for handling and dispatching in-game events.
--
local herald = {}

--
--- Hidden frame used for registering and receiving events.
--
--- @private
--- @type table
--
herald._frame = nil

--
--- Stores event listeners, mapping event names to listeners.
--
--- @private
--- @type dictionary<string, list<function>>
--
herald._listeners = {}

--#region (_setup) @ revision 2024-06-09

--
--- Initializes the event handler.
--
--- @private
--
function herald:_setup()
  self._frame = CreateFrame('Frame')
  self._frame:RegisterEvent('ADDON_LOADED')
  self._frame:SetShown(false)

  self._frame:SetScript('OnEvent',
    function(_, event, ...)
      --- @cast event string
      self:_dispatch(event, ...)
    end
  )
end

--#endregion

--#region (_dispatch) @ revision 2024-06-09

--
--- The core event dispatcher, triggering registered callbacks when events occur.
--- Special handling is implemented for the `ADDON_LOADED` event.
--
--- @param event string
--
function herald:_dispatch(event, ...)
  --#region: Handling of plugin initialization callbacks
  -- For the ADDON_LOADED event, we employ some special logic. A plugin may register
  -- multiple callbacks for its `onload` event, but once the registered callbacks have
  -- been executed, the list is emptied as a plugin will never load more than once.
  --#endregion

  if event == 'ADDON_LOADED' then
    local addon = ... --- @cast addon string
    local callbacks = self._listeners[event .. addon]

    if _type(callbacks) == 'table' then
      for _, listener in _ipairs(callbacks) do
        taskmanager:queue(listener)
      end

      self._listeners[event .. addon] = nil
    end

    return -- note: execution ends here when the event is ADDON_LOADED
  end

  --#region: Handling of other events
  -- For other events, we simply iterate over the listeners and queue them for execution.
  -- The arguments passed to the event are passed along to the listeners.
  --#endregion

  if _type(self._listeners[event]) == 'table' then
    for _, listener in _ipairs(self._listeners[event]) do
      taskmanager:queue(listener, ...)
    end
  end
end

--#endregion

--#region (subscribe) @ revision 2024-06-10

--
--- Subscribes a callback function to a specific event.
--
--- @param event string
--- @param callback function
--
function herald:subscribe(event, callback)
  if self._frame == nil then self:_setup() end

  _assert(event ~= 'ADDON_LOADED',
    "ADDON_LOADED may only be registered through the plugin API"
  )

  if self._listeners[event] == nil then
    self._listeners[event] = {}
    self._frame:RegisterEvent(event)
  end

  _table.insert(self._listeners[event], callback)
end

--#endregion

--#region (unsubscribe) @ revision 2024-06-10

--
--- Unsubscribes a callback function from a specific event.
--
--- @param event string
--- @param callback function
--
function herald:unsubscribe(event, callback)
  if _type(self._listeners[event]) == 'table' then
    for index, listener in _ipairs(self._listeners[event]) do
      if listener == callback then
        _table.remove(self._listeners[event], index)
      end
    end

    if #self._listeners[event] == 0 then
      self._frame:UnregisterEvent(event)
    end
  end
end

--#endregion

--#region (onload) @ revision 2024-06-10

--
--- Registers a callback function to be executed when a specific addon is loaded.
--
--- @param addon string
--- @param callback function
--
function herald:onload(addon, callback)
  local event = 'ADDON_LOADED' .. addon
  if self._frame == nil then self:_setup() end

  if _type(self._listeners[event]) ~= 'table' then
    self._listeners[event] = {}
  end

  _table.insert(self._listeners[event], callback)
end

--#endregion

--#endregion

--#region [module: communication system] @ version 1.0.0

--
--- Facilitates communication between different parts of the system through named channels.
--
local walkietalkie = {}

--
--- Stores the listeners (functions) associated with each communication channel.
--
--- @private
--- @type dictionary<string, list<function>>
--
walkietalkie._channels = {}

--#region (transmit) @ revision 2024-06-10

--
--- Broadcasts a message to all functions listening on a specific channel.
--
--- @param channel string
--
function walkietalkie:transmit(channel, ...)
  if _type(self._channels[channel]) == 'table' then
    for _, listener in _ipairs(self._channels[channel]) do
      taskmanager:queue(listener, ...)
    end
  end
end

--#endregion

--#region (recieve) @ revision 2024-06-10

--
--- Registers a function to listen for messages on a specific channel.
--
--- @param channel string
--- @param callback function
--
function walkietalkie:recieve(channel, callback)
  if _type(self._channels[channel]) ~= 'table' then
    self._channels[channel] = {}
  end

  _table.insert(self._channels[channel], callback)
end

--#endregion

--#endregion

--#region [module: services] @ version 1.0.0

--
--- ???
--
local coordinator = {}

--#endregion

--#region [module: locales] @ version 1.0.0

--
--- ???
--
local linguist = {}

--#endregion

--#region [module: tooltip handler] @ version 1.0.0

--
--- ???
--
local tooltip = {}

--#endregion

--#region [module: saved variables] @ version 1.0.0

--
--- Provides persistent storage for plugin data.
--
local storage = {}

--#region (get) @ revision 2024-06-13

--
--- Retrieves a value from the plugin's storage based on its name and optionally its parent key.
---
--- @param parent string | nil
--- @param variable string
--- @return unknown | nil
--
function storage:get(parent, variable)
  --- @cast self plugin.storage
  local target = self._variables

  if parent ~= nil then
    local t = table_walk(target, parent)
    if t ~= nil then target = t end
  end

  return target[variable]
end

--#endregion

--#region (set) @ revision 2024-06-13

--
--- Stores a value in the plugin's storage under the specified name and optional parent key.
--
--- @param parent string | nil
--- @param variable string
--- @param content unknown
--
function storage:set(parent, variable, content)
  --- @cast self plugin.storage
  local target = self._variables

  if parent ~= nil then
    target = table_walk(target, parent, true) --[[@as table]]
  end

  target[variable] = content
end

--#endregion

--#region: plugin storage initialization @ revision 2024-06-13

--
--- Initializes storage for a newly added plugin, ensuring the
--- saved variables are available for storage operations.
--
walkietalkie:recieve(
  'PLUGIN_ADDED', function(plugin)
    --- @cast plugin plugin

    herald:onload(
      plugin.id, function()
        --#region: Naming convention for saved variables
        -- Saved variable names are prefixed with 'augment_storage_' followed by the plugin's ID,
        -- with hyphens replaced by underscores. This ensures uniqueness and prevents conflicts
        -- with other global variables.
        --#endregion

        local target = 'augment_storage_' .. _string.gsub(plugin.id, '-', '_')
        _G[target] = _type(_G[target]) == 'table' and _G[target] or {}

        plugin.storage = setmetatable(
          { _variables = _G[target] }, { __index = storage }
        )
      end
    )
  end
)

--#endregion

--#endregion

--#region: plugin-specific API @ version 1.0.0

--
--- Provides an interface to allow plugins to interact with the framework.
--
local plugin_api = {}

--
--- Registers a callback function to be executed when the plugin has finished loading.
--
--- @param self plugin
--- @param callback function
--
function plugin_api.onload(self, callback)
  herald:onload('augment.plugin.' .. self.id, callback)
end

--#endregion

--#region [module: plugins] @ version 1.0.0

--
--- Responsible for creating and managing plugins.
--
local architect = {}

--#region (create_plugin) @ revision 2024-06-09

--
--- Creates a new plugin instance with the specified ID and broadcasts its creation.
--
--- @param id string
--- @return plugin
--
function architect:create_plugin(id)
  local context = setmetatable({ id = id }, { __index = plugin_api })
  walkietalkie:transmit('PLUGIN_ADDED', context)

  return context
end

--#endregion

--#endregion

--#region: framework API @ version 1.0.0

--
--- The API for the AUGMENT framework.
--
--- @type API
--
_G.augment = table_readonly(
  {
    channel =
    {
      --
      --- Broadcasts a message to all functions listening on a specific channel.
      --
      transmit = function(channel, ...)
        walkietalkie:transmit(channel, ...)
      end,

      --
      --- Registers a function to listen for messages on a specific channel.
      --
      recieve = function(channel, callback)
        walkietalkie:recieve(channel, callback)
      end
    },

    locale =
    {
      --
      --- ???
      --
    },

    package =
    {
      --
      --- Returns one or more specified packages from the package repository.
      --
      import = function(...)
        return warehouse:import(...)
      end,

      --
      --- Export a package with the specified name to the package repository.
      --
      export = function(package, content)
        warehouse:export(package, content)
      end
    },

    plugin =
    {
      --
      --- Create and return a new plugin instance with the specified ID.
      --
      create = function(id)
        return architect:create_plugin(id)
      end
    },

    tooltip =
    {
      --
      --- ???
      --
    },

    --
    --- Collection of utility functions.
    --
    utility =
    {
      --
      --- Raises a formatted error message, optionally using provided values to
      --- fill in placeholders within the message string.
      --
      exception = exception,

      --
      --- String-related utility functions.
      --
      string =
      {
        --
        --- Divides a string into a list of substrings, using a specified separator
        --- to determine the boundaries between them. If the separator is not found in
        --- the target string, the entire string is returned as a single-element list.
        --
        split = string_split
      },

      --
      --- Table-related utility functions.
      --
      table =
      {
        --
        --- Transforms a regular Lua table into a read-only table, preventing any modifications
        --- to its contents or nested tables. Any attempt to modify the table or its nested values
        --- will raise an error.
        --
        readonly = table_readonly,

        --
        --- Traverses a nested table (like a directory structure) using a dot-separated path string,
        --- returning a reference to the target table if the path is complete or `build_mode` is enabled
        --- (which will create missing intermediate tables), otherwise `nil`.
        --
        walk = table_walk
      }
    }
  } --[[@as API]]
)

--#endregion

--#region (service: widget handler) @ version 1.0.0

--
--- ???
--
local widget = {}

--#endregion

--#region (service: configuration handler) @ version 1.0.0

--
--- ???
--
local config = {}

--#endregion
