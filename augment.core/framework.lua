--
--      #
--     # #   #    #  ####  #    # ###### #    # #####
--    #   #  #    # #    # ##  ## #      ##   #   #
--   #     # #    # #      # ## # #####  # #  #   #
--   ####### #    # #  ### #    # #      #  # #   #
--   #     # #    # #    # #    # #      #   ##   #
--   #     #  ####   ####  #    # ###### #    #   #
--
-- World of Warcraft addon development framework, created by Erik Riklund (2024)
--

--#region: locally scoped global variables
-- Doing this both optimizes the usage of the functions, as we only need a
-- single lookup for each function, and it allows the minifier to mangle them,
-- potentially reducing the size of the distributed bundle.

local _coroutine, _ipairs, _next, _pairs, _string, _table, _type, _unpack =
    coroutine, ipairs, next, pairs, string, table, type, unpack
--#endregion

--#region [function: exception] @ version 1.0.0

--
--- Raises a formatted error message, optionally using provided values to
--- fill in placeholders within the message string.
--
--- @param message string
--- @param ... string | number
--
local exception = function(message, ...)
  error(... and _string.format(message, ...) or message)
end

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

--#region [module: saved variables] @ version 1.0.0

--
--- ???
--
local storage = {}

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

  assert(event ~= 'ADDON_LOADED',
    "Initialization callbacks may only be registered through plugin contexts"
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

--#region: plugin-specific API @ version 1.0.0

--
--- ???
--
local plugin_api = {}

--
--- ???
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
--- ???
--
local architect = {}

--#region (create_plugin) @ revision 2024-06-09

--
--- ???
--
--- @param id string
--- @return plugin
--
function architect:create_plugin(id)
  return setmetatable({ id = id }, { __index = plugin_api })
end

--#endregion

--#endregion

--#region: API @ version 1.0.0

--
--- The API for the AUGMENT framework.
--
_G.augment =
{
  channel =
  {
    --
    --- Broadcasts a message to all functions listening on a specific channel.
    --
    --- @param channel string
    --
    transmit = function(channel, ...)
      walkietalkie:transmit(channel, ...)
    end,

    --
    --- Registers a function to listen for messages on a specific channel.
    --
    --- @param channel string
    --- @param callback function
    --
    recieve = function(channel, callback)
      walkietalkie:recieve(channel, callback)
    end
  },

  event =
  {

  },

  package =
  {
    --
    --- Returns one or more specified packages from the package repository.
    --
    --- @param ... string
    --- @return ...
    --
    import = function(...)
      return warehouse:import(...)
    end,

    --
    --- Export a package with the specified name to the package repository.
    --
    --- @param package string
    --- @param content object
    --
    export = function(package, content)
      warehouse:export(package, content)
    end
  },

  plugin =
  {
    --
    --- ???
    --
    --- @param id string
    --
    create = function(id)
      return architect:create_plugin(id)
    end
  },

  service =
  {

  },

  utility = {
    exception = exception
  }
}

--#endregion
