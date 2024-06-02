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
  channels = {}
}

--#region: type-checking functions
local declare = _G.typical.declare
local required = _G.typical.required
local optional = _G.typical.optional
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

  self:_execute()
end

--#endregion

--#region (method: tasks._execute)

--
--- Starts (or resumes) the task execution coroutine.
--
--- @private
--
function modules.tasks:_execute()
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
--- ???
--
--- @private
--- @type map<string, channel.line>
--
modules.channels.lines = {}

--
--- ???
--
--- @private
--- @type map<string, list<function>>
--
modules.channels.listeners = {}

--#endregion

--#region (method: channels.create)

--
--- ???
--
--- @param owner plugin
--- @param channel string
--- @param private? boolean
--
function modules.channels:open_line(owner, channel, private) end

--#endregion

--#region (method: channels.transmit)

--
--- ???
--
--- @
--
function modules.channels:transmit(sender, channel, ...) end

--#endregion

--#region (method: channels.recieve)

--
--- ???
--
--- @
--
function modules.channels:listen(reciever, channel, callback) end

--#endregion

--#endregion
