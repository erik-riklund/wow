local _addon, _context = ...
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

local _queue = {}

--
--- ???
--
local _task = coroutine.create(
  function()
    while true do
      while 1 <= #_queue do
        local t = table.remove(_queue, 1)
        local success, e = pcall(t.callback, unpack(t.args))
        
        if not success then
          -- note: implement warnings when the debug console is in place.
        end
      end

      coroutine.yield()
    end
  end
)

--
--- ???
--
--- @
--
local execute = function(...)
  local callback, args =
      declare({ ... }, {
        param("callback", "function"),
        param("args", "array", { optional = true })
      })

  table.insert(_queue, { callback = callback, args = args or {} })
  if coroutine.status(_task) == "suspended" then coroutine.resume(_task) end
end

export("core.tasks", "execute", execute, _context)
