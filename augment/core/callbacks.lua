local _, framework = ...

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
local _dispatcher =
    coroutine.create(
      function()
        while true do
          while #_queue > 0 do
            local e = table.remove(_queue, 1)
            local success, exception = pcall(e.callback, table.unpack(e.args))

            if not success then
              print(("Callback execution failed: %s"):format(exception))
            end
          end

          coroutine.yield()
        end
      end
    )

framework.callbacks = {
  register = function(callback, ...)
    if type(callback) ~= "function" then
      throw("Expected type `function` for 'callback'")
    end

    table.insert(_queue, { callback = callback, args = { ... } })
    if _dispatcher and coroutine.status(_dispatcher) == "suspended" then
      coroutine.resume(_dispatcher)
    end
  end
}
