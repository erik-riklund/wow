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
-- World of Warcraft addon ecosystem, created by Erik Riklund (2024)
--

--#region [scoped variables]

local modules = {}
local declare, required, optional = _G.typical.declare, _G.typical.required, _G.typical.optional

--#endregion
--#region [module: tasks]

modules.tasks =
{
  --
  --- A queue of tasks to be executed.
  --
  --- @type list<task>
  --
  _queue = {},

  --
  --- Coroutine that manages the execution of tasks from the queue. It continuously processes
  --- tasks until the queue is empty, yielding after each task to allow other coroutines to run.
  --
  _handler = coroutine.create(
    function()
      local self = modules.tasks

      while (true) do
        while #self._queue > 0 do
          local task = table.remove(self._queue, 1) --[[@as task]]
          local success, error = pcall(task.callback, unpack(task.arguments))

          if success == false then
            -- note: implement warnings later on!
          end
        end

        coroutine.yield()
      end
    end
  )
}

--#region [method: tasks.add]

--
--- Queues a task to be executed as a background task, ensuring the callback function
--- is valid before adding it to the queue and resuming the coroutine if it is suspended.
--
--- @param callback function
--- @param ... any
--
function modules.tasks:add(callback, ...)
  callback = declare({ callback, required('function') }) --[[@as function]]

  table.insert(self._queue,
    ({ callback = callback, arguments = { ... } } --[[@as task]])
  )

  if coroutine.status(self._handler) == 'suspended' then
    coroutine.resume(self._handler)
  end
end

--#endregion
--#endregion
--#region [module: message]

modules.messages =
{
  --
  --- ???
  --
  --- @type map<string, string>
  --
  channels = {},

  --
  --- ???
  --
  --- @type map<string, list<function>>
  --
  listeners = {}
}

--#region [method: message.reserve]

--
--- ???
--
--- @param plugin plugin
--- @param channel string
--- @param private? boolean
--
function modules.messages:reserve(plugin, channel, private)
  plugin, channel, private = declare(
    { plugin, required('plugin') },
    { channel, required('string') },
    { private, optional('boolean', false) }
  )

  -- ???
end

--#endregion
--#region [method: message.recieve]

--
--- ???
--
--- @param plugin plugin
--- @param channel string
--- @param callback function
--
function modules.messages:recieve(plugin, channel, callback)
  plugin, channel, callback = declare(
    { plugin, required('plugin') },
    { channel, required('string') },
    { callback, required('function') }
  )

  -- ???
end

--#endregion
--#region [method: message.transmit]

--
--- ???
--
--- @param plugin plugin
--- @param channel string
--- @param payload any
--
function modules.messages:transmit(plugin, channel, payload)
  plugin, channel, payload = declare(
    { plugin, required('plugin') },
    { channel, required('string') },
    { payload, required('any') }
  )

  -- ???
end

--#endregion
--#endregion
--#region [module: plugins]



--#endregion
--#region [api]

_G.augment = {}

--#endregion
