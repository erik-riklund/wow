local _addon, _core = ...
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

--#region [ "global" variables ]

--
--- ???
--
local modules =
{
  --
  --- ???
  --
  tasks = {},

  --
  --- ???
  --
  channels = {},

  --
  --- ???
  --
  events = {}
}

--#region: error functions
local throw = _G.exception.throw
--#endregion

--#region: type-checking functions
local declare = _G.typical.declare
local required = _G.typical.required
local optional = _G.typical.optional
--#endregion

--#region: ui-related functions
local ui = _G.augment.ui
--#endregion

--#endregion

--#region [ module: tasks ]

--#region (fields)

--
--- Used to store tasks awaiting execution.
--
--- @private
--- @type list<task>
--
modules.tasks.queue = {}

--
--- The coroutine that handles the execution of tasks from the queue.
--
--- @private
--- @type thread
--
modules.tasks.handler = nil

--#endregion

--#region (method: tasks.register)

--
--- Registers a new task for execution.
--
--- @param callback function
--
function modules.tasks:register(callback, ...)
  callback = declare({ callback, required('function') })

  table.insert(self.queue,
    { callback = callback --[[@as function]], arguments = { ... } } --[[@as task]]
  )
end

--#endregion

--#region (method: tasks._execute)

--
--- Initializes or resumes the task execution coroutine.
--
function modules.tasks:execute()
  if self.handler == nil then self:_setup() end
  if coroutine.status(self.handler) == 'suspended' then coroutine.resume(self.handler) end
end

--#endregion

--#region (method: tasks._setup)

--
--- Initializes the task execution coroutine if it hasn't been set up yet.
--
--- @private
--
function modules.tasks:_setup()
  self.handler = coroutine.create(
    function()
      while (true) do
        while #self.queue > 0 do
          local task = table.remove(self.queue, 1) --[[@as task]]
          local success, result = pcall(task.callback, unpack(task.arguments))

          if not success then
            -- todo: implement warnings
          end
        end

        coroutine.yield()
      end
    end
  )
end

--#endregion

--#endregion

--#region [ module: channels ]

--#region (fields)

--
--- Stores channel information, mapping channel names to their associated data.
--
--- @private
--- @type map<string, channel.line>
--
modules.channels.lines = {}

--
--- Keeps track of the functions (listeners) registered to receive messages
--- on each channel.
--
--- @private
--- @type map<string, list<function>>
--
modules.channels.listeners = {}

--#endregion

--#region (method: channels.create)

--
--- Establishes a new named communication channel, specifying its owner plugin
--- and whether it is private or public.
--
--- @param owner plugin
--- @param channel string
--- @param private? boolean
--
function modules.channels:open_line(owner, channel, private)
  --#region: parameter declarations
  owner, channel, private = declare(
    { owner, required('plugin') }, { channel, required('string') },
    { private, optional('boolean', false) }
  )

  --- @cast owner plugin
  --- @cast channel string
  --- @cast private boolean
  --#endregion

  if self.lines[channel] ~= nil then
    throw("Unable to open channel '%s' as it already exists", channel)
  end

  self.lines[channel] = { owner = owner, private = private }
end

--#endregion

--#region (method: channels.transmit)

--
--- Broadcasts a message through a specific channel, triggering the execution
--- of all registered listener functions.
--
--- @param sender plugin
--- @param line string
--
function modules.channels:transmit(sender, line, ...)
  --#region: parameter declarations
  sender, line = declare(
    { sender, required('plugin') }, { line, required('string') }
  )

  --- @cast sender plugin
  --- @cast line string
  --#endregion

  if self.lines[line] == nil then
    throw("Unable to transmit to non-existent line '%s'", line)
  end

  if self.lines[line].owner ~= sender then
    throw("Denied transmission request for line '%s' from non-owner context")
  end

  if self.listeners[line] ~= nil then
    for _, reciever in ipairs(self.listeners[line]) do
      modules.tasks:register(reciever, ...)
    end

    modules.tasks:execute()
  end
end

--#endregion

--#region (method: channels.listen)

--
--- Subscribes a function (listener) to a particular channel, allowing it to
--- receive messages transmitted on that channel.
--
--- @param reciever plugin
--- @param line string
--- @param callback function
--
function modules.channels:listen(reciever, line, callback)
  --#region: parameter declarations
  reciever, line, callback = declare(
    { reciever, required('plugin') }, { line, required('string') },
    { callback, required('function') }
  )

  --- @cast reciever plugin
  --- @cast line string
  --- @cast callback function
  --#endregion

  if self.lines[line] == nil then
    throw("Unable to listen to non-existent line '%s'", line)
  end

  local line_options = self.lines[line]
  if line_options.private and line_options.owner ~= reciever then
    throw("Denied listening request for private line '%s'", line)
  end

  self.listeners[line] = self.listeners[line] or {}
  table.insert(self.listeners[line], callback)
end

--#endregion

--#endregion

--#region [ module: events ]

--#region (fields)

--
--- ???
--
--- @private
--
--modules.events.frame = 

--#endregion

--#endregion
