--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|
--
-- ADDON DEVELOPMENT FRAMEWORK created by Erik Riklund (2024)
--

local addon, context = ...

--#region: local variables

--
--- Provides a collection of utility functions for working with tables.
--
local _table = {}

--
--- Provides a collection of utility functions for working with strings.
--
local _string = {}

--#endregion

--#region (locally scoped global variables)
--
--- Creates local references to frequently used global functions and tables,
--- improving performance by avoiding repeated global lookups during runtime.
--

local assert, collectgarbage, error, ipairs, pairs, type =
    assert, collectgarbage, error, ipairs, pairs, type

local coroutine, string, table = coroutine, string, table

--#endregion

--#region [module: libraries]

--#region [library: standalone utility functions]

--#region [function: throw]

--
--- Raises a formatted error message, optionally using provided values to fill in placeholders
--- within the message string. The error is raised from the caller's context.
---
--- @param exception string The error message template.
--- @param ... string | number Optional values to insert into the message.
--
local throw = function(exception, ...)
  --#region: Why do we use return when error has no return value?
  -- To facilitate mocking of the error() function during unit testing, where we want to
  -- catch the error message as a string to determine if the outcome is what we expect.
  --#endregion

  return error(... and string.format(exception, ...) or exception, 3)
end

--#endregion

--#endregion

--#region [library: collections]

--#region [class: map]

--
--- Provides functionality for creating and manipulating custom map (key-value) objects.
--
local map_controller =
{
  --
  --- @param self map
  --- @param key unknown
  --
  get = function(self, key) return self.data[key] end,

  --
  --- @param self map
  --- @param key unknown
  --- @param value unknown
  --
  set = function(self, key, value) self.data[key] = value end,

  --
  --- @param self map
  --- @param key unknown
  --
  has = function(self, key) return self:get(key) ~= nil end,

  --
  --- @param self map
  --- @param search_value unknown
  --
  contains = function(self, search_value)
    for key, value in pairs(self.data) do
      if value == search_value then return key end
    end
  end,

  --
  --- @param self map
  --
  size = function(self)
    local count = 0
    for _ in pairs(self.data) do
      count = count + 1
    end

    return count
  end,

  --
  --- @param self map
  --
  values = function(self) return self.data end
}

--
--- Creates a new map instance, optionally initialized with provided key-value pairs.
---
--- @param initial_content record<unknown, unknown>? (optional) A table of initial key-value pairs for the map.
--- @param options map.options?
---
--- @return map
--
local function map(initial_content, options)
  initial_content = (type(initial_content) == 'table' and initial_content) or {}

  if type(options) == 'table' and options.weak then
    initial_content = setmetatable(initial_content, { __mode = 'k' })
  end

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
  --- @param self list
  --- @param index number
  --
  get = function(self, index)
    return self.data[index]
  end,

  --
  --- @param self list
  --- @param value unknown
  --
  contains = function(self, value)
    return self:indexof(value) ~= -1
  end,

  --
  --- @param self list
  --- @param value unknown
  --
  indexof = function(self, value)
    for i, current_value in ipairs(self.data) do
      if current_value == value then return i end
    end

    return -1 -- note: used when the value isn't found.
  end,

  --
  --- @param self list
  --- @param value unknown
  --- @param position number?
  --
  insert = function(self, value, position)
    table.insert(self.data, position or (#self.data + 1), value)
  end,

  --
  --- @param self list
  --- @param position number?
  --
  remove = function(self, position)
    return table.remove(self.data, position or #self.data)
  end,

  --
  --- @param self list
  --
  length = function(self) return #self.data end,

  --
  --- @param self list
  --
  values = function(self) return self.data end
}

--
--- Creates a new list instance, optionally initialized with provided values.
---
--- @param initial_values array<unknown>? (optional) An array of initial values for the list.
--- @return list
--
local function list(initial_values)
  initial_values = (type(initial_values) == 'table' and initial_values) or {}
  return setmetatable({ data = initial_values }, { __index = list_controller })
end

--#endregion

--#endregion

--#region [library: string-related utility functions]

--#region [function: split]

--
--- Divides a string into a list of substrings, using a specified separator
--- to determine the boundaries between them. If the separator is not found in
--- the target string, the entire string is returned as a single-element list.
--
--- @param target string
--- @param separator string
--
--- @return array<string>
--
_string.split = function(target, separator)
  return { string.split(separator, target) }
end

--#endregion

--#endregion

--#region [library: table-related utility functions]

--#region [function: walk]

--
--- Traverses a nested table (like a directory structure) using a list of path names,
--- returning a reference to the target table if the path is complete or `build_mode`
--- is enabled (which will create missing intermediate tables), otherwise `nil`.
--
--- @param target table
--- @param path array<unknown>
--- @param options { build_mode: boolean? }?
--
--- @return table | nil
--
_table.walk = function(target, path, options)
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
      throw(
        'Unexpected non-table value encountered at `%s`',
        table.concat(path, '.', 1, i)
      )
    end

    reference = reference[ancestor] --[[@as table]]
  end

  return reference
end

--#endregion

--#region [function: immutable]

--
--- ?
---
--- @param target table
--- @return table
--
_table.immutable = function(target)
  local proxy = {}

  --- ?
  local immutable_controller =
  {
    __newindex = function()
      throw('Attempt to modify a read-only table')
    end,

    __index = function(self, key)
      local value = target[key]

      return (type(value) == 'table' and _table.immutable(value)) or value
    end
  }

  return setmetatable(proxy, immutable_controller)
end

--#endregion

--#endregion

--#endregion

--#region: framework resources

--
--- The main frame for the framework, used for registering and handling events.
--
local frame = CreateFrame('Frame', 'CogspinnerFrame')

--
--- Registers the ADDON_LOADED event used to trigger initialization logic when plugins are loaded.
--
frame:RegisterEvent('ADDON_LOADED')

--#endregion

--#region [module: tasks]

--
--- Responsible for managing and executing tasks in a time-sliced manner to maintain frame rate.
--
local task_handler = { jobs = list() }

--
--- A coroutine that processes tasks from the queue, ensuring that the execution time
--- per frame does not exceed the specified limit (targeting 60fps).
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
--- Queues a task for execution, adding it to the list of pending tasks.
---
--- @param callback function The function to be executed as the task.
--- @param ... unknown The arguments to be passed to the callback function.
--
function task_handler:queue(callback, ...)
  self.jobs:insert({ callback = callback, arguments = { ... } } --[[@as task]])
end

--
--- Hooks into the `OnUpdate` event to resume the task processing coroutine
--- whenever there are tasks in the queue.
--
frame:SetScript('OnUpdate', function()
  if coroutine.status(task_process) == 'suspended' then
    if task_handler.jobs:length() > 0 then coroutine.resume(task_process) end
  end
end)

--#endregion

--#region [module: events]

--
--- Responsible for managing event subscriptions and triggering callbacks when events occur.
--
local event_handler = { listeners = map() }

--
--- Used to store listeners for the 'ADDON_LOADED' event, organized by plugin IDs.
--
event_handler.listeners:set('ADDON_LOADED', map())

--
--- Registers a listener for a specified event.
---
--- @param plugin_id string The unique identifier of the plugin registering the listener.
--- @param options event.listener.options The options for the listener.
--
function event_handler:listen(plugin_id, options)
  if not self.listeners:has(options.event) then
    frame:RegisterEvent(options.event)
    self.listeners:set(options.event, list())
  end

  if options.event == 'ADDON_LOADED' then
    --- @type map
    local plugins = self.listeners:get('ADDON_LOADED')

    if not plugins:has(plugin_id) then
      plugins:set(plugin_id, list())
    end

    --- @type list
    local plugin_listeners = plugins:get(plugin_id)

    plugin_listeners:insert(
      { plugin_id = plugin_id, callback = options.callback, trigger = 'once' } --[[@as event.listener]]
    )
  else
    --- @type list
    local listeners = self.listeners:get(options.event)

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
--- Unsubscribes one (if a callback ID is specified) or all listeners for a specific event.
---
--- @param event string The name of the event to unsubscribe from.
--- @param plugin_id string The unique identifier of the plugin that registered the listener.
--- @param callback_id string? (optional) A unique identifier for a specific callback within the plugin.
--
function event_handler:silence(event, plugin_id, callback_id)
  if event ~= 'ADDON_LOADED' and self.listeners:has(event) then
    --- @type list
    local listeners = self.listeners:get(event)

    for i = listeners:length(), 1, -1 do
      local listener = listeners:get(i) --[[@as event.listener]]

      if plugin_id == listener.plugin_id then
        if callback_id == nil or (callback_id ~= nil and listener.callback_id == callback_id) then listeners:remove(i) end
      end
    end
  end
end

--
--- The main event handler, triggered when an in-game event occurs.
--
frame:SetScript('OnEvent',
  function(_, event, ...)
    if event == 'ADDON_LOADED' then
      --#region: Handle ADDON_LOADED event
      -- Process and remove listeners for the 'ADDON_LOADED' event associated with the loaded plugin.
      --#endregion

      local addon_id = ...
      local plugins = event_handler.listeners:get('ADDON_LOADED') --[[@as map]]

      if plugins:has(addon_id) then
        local listeners = plugins:get(addon_id) --[[@as list]]

        for _, listener in ipairs(listeners:values()) do
          --- @cast listener event.listener
          task_handler:queue(listener.callback)
        end

        plugins:set(addon_id, nil)
      end
    else
      --#region: Handle other events
      -- Retrieve and queue registered listeners for the triggered event,
      -- respecting the 'trigger' option for each listener.
      --#endregion

      if event_handler.listeners:has(event) then
        local callbacks = list()
        local listeners = event_handler.listeners:get(event) --[[@as list]]

        for i = listeners:length(), 1, -1 do
          local listener = listeners:get(i) --[[@as event.listener]]
          callbacks:insert(listener.callback)

          if listener.trigger == 'once' then listeners:remove(i) end
        end

        for i = callbacks:length(), 1, -1 do
          task_handler:queue(callbacks:get(i) --[[@as function]], ...)
        end
      end
    end
  end
)

--#endregion

--#region: event API

--
--- Provides an interface for plugins to interact with the event system,
--- allowing them to register and unregister event listeners.
--
local event_api = {}

--
--- @param self event.api
--- @param options event.listener.options
--
function event_api.listen(self, options)
  event_handler:listen(self.context.id, options)
end

--
--- @param self event.api
--- @param event string
--- @param callback_id string?
--
function event_api.silence(self, event, callback_id)
  event_handler:silence(event, self.context.id, callback_id)
end

--#endregion

--#region [module: storage]

--
--- Provides methods for managing and accessing saved variables.
--
local storage_controller =
{
  --
  --- @param self storage.unit
  --- @param variable_path string
  ---
  --- @return unknown
  --
  get = function(self, variable_path)
    local target, variable = self:resolve(variable_path, false)
    return (type(target) == 'table' and target[variable]) or nil
  end,

  --
  --- @param self storage.unit
  --- @param variable_path string
  --- @param value unknown
  --
  set = function(self, variable_path, value)
    local target, variable = self:resolve(variable_path, true)
    target[variable] = value
  end,

  --
  --- @param self storage.unit
  --- @param variable_path string
  --
  drop = function(self, variable_path)
    local target, variable = self:resolve(variable_path, false)
    if type(target) == 'table' then target[variable] = nil end
  end,

  --
  --- @private
  ---
  --- @param self storage.unit
  --- @param variable_path string
  --- @param build_mode boolean
  ---
  --- @return table | nil, string
  --
  resolve = function(self, variable_path, build_mode)
    local target = self.data --[[@as table|nil]]
    local variable = variable_path

    if string.find(variable_path, '.') then
      local ancestors = _string.split(variable_path, '.')
      variable = table.remove(ancestors) --[[@as string]]

      target = _table.walk(target --[[@as table]], ancestors, { build_mode = build_mode })
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
--
function storage_handler:setup(plugin)
  plugin:onload(
    function()
      for _, level in ipairs({ 'account', 'character' }) do
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
  )
end

--#endregion

--#region [module: network]

--
--- The network module manages communication channels between plugins, allowing
--- them to reserve, transmit on, and receive messages from specific channels.
--- It ensures that only the owning plugin can transmit on a channel and provides
--- functionality for other plugins to register listeners to receive messages.
--
local network = { channels = map() }

--
--- @param plugin plugin
--- @param channels array<string>
--
function network:reserve(plugin, channels)
  for _, channel in ipairs(channels) do
    if self.channels:has(channel) then
      throw('Unable to reserve occupied channel `%s` for plugin %s', channel, plugin.id)
    end

    self.channels:set(channel, { owner = plugin, listeners = list() })
  end
end

--
--- @param plugin plugin
--- @param channel string
--- @param callback function
--
function network:recieve(plugin, channel, callback)
  if not self.channels:has(channel) then
    throw('Attempt to recieve payloads from unknown channel `%s` (plugin: %s)', channel, plugin.id)
  end

  --- @type network.channel
  local channel_data = self.channels:get(channel)
  channel_data.listeners:insert(callback)
end

--
--- @param plugin plugin
--- @param channel string
--- @param payload unknown?
--
function network:transmit(plugin, channel, payload)
  if not self.channels:has(channel) then
    throw('Unable to transmit to unknown channel `%s` (plugin: %s)', channel, plugin.id)
  end

  --- @type network.channel
  local channel_data = self.channels:get(channel)

  if channel_data.owner ~= plugin then
    throw('Unable to transmit to channel `%s` reserved by other plugin (plugin: %s)', channel, plugin.id)
  end

  for _, callback in ipairs(channel_data.listeners:values()) do
    task_handler:queue(callback, payload)
  end
end

--#endregion

--#region: network API

--
--- Provides an interface for plugins to interact with the network communication system.
--
local network_api = {}

--
--- @param self network.api
--- @param channel string
--- @param payload unknown?
--
function network_api.transmit(self, channel, payload)
  network:transmit(self.context, channel, payload)
end

--
--- @param self network.api
--- @param channel string
--- @param callback function
--
function network_api.recieve(self, channel, callback)
  network:recieve(self.context, channel, callback)
end

--#endregion

--#region [module: locales]

--
--- ?
--
local locale_handler = {
  locales = map({ Cogspinner = map() })
}

--
--- @param data locale.data
--
function locale_handler:register(data)
  if not self.locales:has(data.plugin) then
    self.locales:set(data.plugin, map())
  end

  --- @type map
  local plugin_locales = self.locales:get(data.plugin)

  plugin_locales:set(data.locale, map(data.content))

  if type(data.default) == 'boolean' and data.default then
    plugin_locales:set('default', map(data.content))
  end
end

--
--- @param plugin_id string
--- @param label string
--
function locale_handler:retrieve(plugin_id, label)
  if self.locales:has(plugin_id) then
    --- @type map
    local locales = self.locales:get(plugin_id)

    --- @type map | nil
    local locale = locales:get(GetLocale()) or locales:get('default')

    return (locale ~= nil and locale:get(label)) or string.format(
      'Missing localized string (plugin: %s, locale: %s, label: %s)', plugin_id, GetLocale(), label
    )
  end
end

--#endregion

--#region: locale API

--
--- ?
--
local locale_api = {}

--
--- @param self locale.api
--- @param label string
--
function locale_api.get(self, label)
  return locale_handler:retrieve(self.context.id, label)
end

--#endregion

--#region [module: services]

--
--- ?
--
local service_manager = {}

--
--- ?
--
service_manager.services = map()

--
--- @param id string
--
function service_manager:provide(id) end

--
--- @param service service
--
function service_manager:register(service) end

--#endregion

--#region [module: resource exchange]

--
--- ?
--
local resource_manager = {}

--
--- @private
--
resource_manager.exports = map()

--
--- @param id string
--- @return resource
--
function resource_manager:retrieve(id) end

--
--- @param id string
--- @param resource resource
--
function resource_manager:register(id, resource) end

--#endregion

--#region [module: tooltip controller]

--
--- ?
--
local tooltip_controller = {}

--#endregion

--#region: plugin API

--
--- Provides a collection of methods for plugin interaction and management.
--
local plugin_api = {}

--
--- @param self plugin
--- @param callback function
--
function plugin_api.onload(self, callback)
  self.event:listen(
    { event = 'ADDON_LOADED', callback = callback, trigger = 'once' }
  )
end

--#endregion

--#region [module: plugins]

--
--- Manages the lifecycle of plugins.
--
local plugin_manager = { registry = list() }

--
--- @param identifier string
--- @param options plugin.options?
--
function plugin_manager:initialize(identifier, options)
  self:register(identifier)
  local plugin = setmetatable({ id = identifier }, { __index = plugin_api }) --[[@as plugin]]
  self:setup(plugin, (type(options) == 'table' and options) or {})

  return plugin
end

--
--- @private
---
--- @param identifier string
--
function plugin_manager:register(identifier)
  if string.match(identifier, '^[a-zA-Z0-9_]+$') == nil then
    throw(
      'Invalid plugin identifier, may only contain underscores,'
      .. ' letters (`a-z`, `A-Z`) and numbers.'
    )
  end

  if self.registry:contains(identifier) then
    throw('Unable to register plugin with non-unique identifier `%s`', identifier)
  end

  self.registry:insert(identifier)
end

--
--- @private
---
--- @param plugin plugin
--- @param options plugin.options
--
function plugin_manager:setup(plugin, options)
  plugin.event = setmetatable({ context = plugin }, { __index = event_api })
  plugin.network = setmetatable({ context = plugin }, { __index = network_api })
  plugin.locale = setmetatable({ context = plugin }, { __index = locale_api })

  storage_handler:setup(plugin)

  if type(options.channels) == 'table' then
    network:reserve(plugin, options.channels --[[@as array<string>]])
  end
end

--#endregion

--#region: framework API

_G.cogspinner =
{
  --
  --- ?
  ---
  --- @param data locale.data
  --
  locale = function(data)
    locale_handler:register(data)
  end,

  --
  --- ?
  ---
  --- @param identifier string
  --- @param options plugin.options?
  --
  plugin = function(identifier, options)
    return plugin_manager:initialize(identifier, options)
  end,

  ---
  ---
  ---
  resource =
  {
    --
    --- ?
    ---
    --- @param id string
    --
    import = function(id)
      return resource_manager:retrieve(id)
    end,

    --
    --- ?
    ---
    --- @param id string
    --- @param resource resource
    --
    export = function(id, resource)
      resource_manager:register(id, resource)
    end
  },

  --
  --- Handy toolbox of functions for various tasks.
  --
  utility = {
    throw = throw, collection = { list = list, map = map }, string = _string, table = _table
  }
}

--#endregion
