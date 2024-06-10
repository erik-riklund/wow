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
-- single lookup for each function, and allows the minifier to uglify them,
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

--#region [module: type checking] @ version 1.0.0

--
--- Responsible for validating parameters and schemas based on provided expectations.
--
local typechecker = { production = false }

--#region (examine) @ revision 2024-06-08

--
--- Determines the data type of a given value, returning it as a string representation.
--- Supports basic Lua types and extended types for tables (list, dictionary).
--
--- @param value any
--- @return string
--
function typechecker:examine(value)
  local value_type = _type(value)

  if value_type == 'table' then
    return #value > 0 and 'list' or _next(value) ~= nil and 'dictionary' or 'table'
  end

  return value_type == 'nil' and 'undefined' or value_type
end

--#endregion

--#region (declare) @ revision 2024-06-08

--
--- Validates a sequence of values against their corresponding parameter definitions,
--- ensuring they meet the specified type and validation criteria. If all values pass
--- validation, they are unpacked and returned as individual arguments; otherwise,
--- the first validation error is thrown, halting execution.
--
--- @param ... type.parameter
--- @return ...
--
function typechecker:declare(...)
  local arguments = ({} --[[@as list<any>]])

  for i, parameter in _ipairs({ ... }) do
    local value, options = parameter[1], parameter[2]
    local result = self:validate(value, options)

    if result.error then
      --#region: Why use return with throw?
      -- We do this for testing purposes, to allow mocking of the `exception`
      -- method to return the error messages instead of triggering a Lua error.
      --#endregion

      return exception("Type error for argument #%d: %s", i, result.error)
    end

    _table.insert(arguments, result.value)
  end

  return _unpack(arguments)
end

--#endregion

--#region (validate) @ revision 2024-06-08

--
--- Acts as a gatekeeper, ensuring that a given value adheres to a set of predefined
--- validation rules (the options). It first checks for basic type compatibility and,
--- if necessary, delves deeper to examine complex data structures according to a schema.
--
--- If the value passes all checks, it is returned (possibly modified); otherwise,
--- the first encountered violation is reported.
--
--- @param value any
--- @param options type.validation.options
--- @param parent? string
--
--- @return type.validation.result
--
function typechecker:validate(value, options, parent)
  local result = (
    { value = value or options.default } --[[@as type.validation.result]]
  )

  if self.production == true then
    return result -- note: no validation performed in production mode!
  end

  if _type(options.expect) == 'string' then
    --#region: Explanation of the type validation logic:
    -- 1. Check if there is a value (not nil) OR the parameter is required (not optional).
    --    If so, and the actual type doesn't match the expected type, proceed to the next step.
    -- 2. If the expected type is 'list' or 'map', AND the actual type is 'table', the validation passes.
    -- 3. If the expected type is not 'any', an error is raised due to the type mismatch from the first step.
    --    If the expected type is 'any', and the actual value is 'undefined' (nil), an error is raised.
    --#endregion

    local actual_type = self:examine(result.value)
    local expected_type = options.expect --[[@as string]]

    if (value ~= nil or options.optional ~= true) and actual_type ~= expected_type then
      if not ((expected_type == 'list' or expected_type == 'map') and actual_type == 'table') then
        if expected_type ~= 'any' or expected_type == 'any' and actual_type == 'undefined' then
          result.error = _string.format('Expected a value of type `%s` but recieved `%s`', expected_type, actual_type)
        end
      end
    end
  end

  if _type(options.expect) == 'table' then
    local schema_result = self:validate_schema(
      value, options.expect --[[@as type.schema]], parent
    )

    if schema_result.error then
      result.error = schema_result.error
      result.path = schema_result.path
    end
  end

  return result
end

--#endregion

--#region (validate_schema) @ revision 2024-06-08

--
--- Recursively validates a complex data structure (table) against a predefined schema,
--- ensuring that each property in the table conforms to its corresponding definition in the schema.
--
--- It performs nested validations for properties with complex types (defined by another schema)
--- and tracks the path to the property where any validation error occurs. If the data structure
--- passes all checks, the potentially modified structure is returned; otherwise, a detailed error
--- message pinpointing the invalid property and its path is returned.
--
--- @param target table
--- @param schema type.schema
--- @param parent? string
--
--- @return type.validation.result
--
function typechecker:validate_schema(target, schema, parent)
  local result = (
    { value = target } --[[@as type.validation.result]]
  )

  for property, _ in _pairs(target) do
    if schema[property] == nil then
      result.error = "Unexpected property: '" .. property .. "' is not defined in the schema"
      return result
    end
  end

  for property, options in _pairs(schema) do
    local heritage = (parent or '') .. '/' .. property

    local property_validation = self:validate(
      target[property], options, _type(options.expect) == 'table' and heritage or nil
    )

    if property_validation.error then
      result.error = property_validation.error
      result.path = property_validation.path or heritage

      break -- note: abort the rest of the validation process
    end

    result.value[property] = property_validation.value
  end

  if not parent and result.error then
    result.error = ("Schema validation failed @ \"%s\": %s"):format(result.path, result.error)
  end

  return result
end

--#endregion

--#region (required) @ revision 2024-06-08

--
--- Generates validation options for a required parameter or property,
--- specifying the expected data type and marking it as not optional.
--
--- @param expected_type string|type.schema
--- @return type.validation.options
--
function typechecker:required(expected_type)
  return { expect = expected_type, optional = false }
end

--#endregion

--#region (optional) @ revision 2024-06-08

--
--- Generates validation options for an optional parameter or property,
--- specifying the expected data type, marking it as optional, and providing
--- a default value to be used if the value is not provided.
--
--- @param expected_type string|type.schema
--- @param default_value? any
--
--- @return type.validation.options
--
function typechecker:optional(expected_type, default_value)
  return { expect = expected_type, optional = true, default = default_value }
end

--#endregion

--#endregion

--#region [module: package system] @ version 1.0.0

--
--- Responsible for managing the import and export of code packages within the system.
--
local packagehandler = {}

--
--- Stores the exported packages, indexed by their names.
--
--- @private
--- @type dictionary<string, object>
--
packagehandler._exports = {}

--#region (import) @ revision 2024-06-08

--
--- Returns one or more specified packages from the package repository.
--
--- @param ... string
--- @return ...
--
function packagehandler:import(...)
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
function packagehandler:export(package, content)
  if self._exports[package] ~= nil then
    return exception("Export failed, the package '%s' already exists", package)
  end

  self._exports[package] = content
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
function packagehandler:_load(package)
  return self._exports[package] or exception("Import failed, unknown package '%s'", package)
end

--#endregion

--#endregion

--#region [module: background tasks] @ version 1.0.0

--
--- Responsible for managing and executing tasks.
--
local taskhandler = {}

--
--- The list of tasks awaiting execution.
--
--- @private
--- @type list<task>
--
taskhandler._tasks = {}

--
--- Coroutine that handles the execution of tasks from the queue.
--
--- @private
--- @type thread
--
taskhandler._process = nil

--#region (queue) @ revision 2024-06-09

--
--- Adds a new task to the execution queue.
--
--- @param callback function
--
function taskhandler:queue(callback, ...)
  if _type(callback) == 'function' then
    _table.insert(self._tasks, { callback = callback, arguments = { ... } } --[[@as task]])
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
function taskhandler:_execute(task)
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
function taskhandler:_setup()
  if self._process == nil then
    self._process = _coroutine.create(
      function()
        while true do
          while #self._tasks > 0 do
            self:_execute(_table.remove(self._tasks, 1) --[[@as task]])
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
local eventhandler = {}

--
--- Hidden frame used for registering and receiving events.
--
--- @private
--- @type table
--
eventhandler._frame = nil

--
--- Stores event listeners, mapping event names to listeners.
--
--- @private
--- @type dictionary<string, list<function>>
--
eventhandler._listeners = {}

--#region (_setup) @ revision 2024-06-09

--
--- Initializes the event handler.
--
--- @private
--
function eventhandler:_setup()
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
function eventhandler:_dispatch(event, ...)
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
        taskhandler:queue(listener)
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
      taskhandler:queue(listener, ...)
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
function eventhandler:subscribe(event, callback)
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
function eventhandler:unsubscribe(event, callback)
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
function eventhandler:onload(addon, callback)
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
--- ???
--
local radiochannel = {}

--#endregion

--#region [module: plugins] @ version 1.0.0

--
--- ???
--
local pluginhandler = {}

--#region (create_plugin) @ revision 2024-06-09

--
--- ???
--
--- @param id string
--- @return plugin.context
--
function pluginhandler:create_plugin(id)
  local context = ({ id = id } --[[@as plugin.context]])

  -- todo: implement API integration methods and services?

  return context
end

--#endregion

--#endregion

--#region [module: services] @ version 1.0.0
--#endregion

--#region: API @ version 1.0.0

--
--- The API for the AUGMENT framework.
--
_G.augment =
{
  exception = exception,

  channel = {},
  event = {},

  package =
  {
    --
    --- Returns one or more specified packages from the package repository.
    --
    --- @param ... string
    --- @return ...
    --
    import = function(...)
      return packagehandler:import(...)
    end,

    --
    --- Export a package with the specified name to the package repository.
    --
    --- @param package string
    --- @param content object
    --
    export = function(package, content)
      packagehandler:export(package, content)
    end
  },

  plugin =
  {
    create = function(id)
      return pluginhandler:create_plugin(id)
    end
  },

  type_checker =
  {
    --
    --- Determines the data type of a given value, returning it as a string representation.
    --- Supports basic Lua types and extended types for tables (list, dictionary).
    --
    --- @param value any
    --- @return string
    --
    examine = function(value)
      return typechecker:examine(value)
    end,

    --
    --- Validates a sequence of values against their corresponding parameter definitions,
    --- ensuring they meet the specified type and validation criteria. If all values pass
    --- validation, they are unpacked and returned as individual arguments; otherwise,
    --- the first validation error is thrown, halting execution.
    --
    --- @param ... type.parameter
    --- @return ...
    --
    declare = function(...)
      return typechecker:declare(...)
    end,

    --
    --- Generates validation options for a required parameter or property,
    --- specifying the expected data type and marking it as not optional.
    --
    --- @param expected_type string|type.schema
    --- @return type.validation.options
    --
    required = function(expected_type)
      return typechecker:required(expected_type)
    end,

    --
    --- Generates validation options for an optional parameter or property,
    --- specifying the expected data type, marking it as optional, and providing
    --- a default value to be used if the value is not provided.
    --
    --- @param expected_type string|type.schema
    --- @param default_value? any
    --
    --- @return type.validation.options
    --
    optional = function(expected_type, default_value)
      return typechecker:optional(expected_type, default_value)
    end
  }
}

--#endregion
