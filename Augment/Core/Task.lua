local error, type = error, type
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
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--[ Task ]
--
-- A utility module for managing the execution of synchronous and asynchronous tasks.
--
local Task = {
  --
  --[ Run ]
  --
  -- Immediately executes the given callback function with the provided arguments.
  --
  Run = function(self, callback, ...)
    if type(callback) ~= "function" then
      error(("Expected type `function` for 'callback', recieved `%s`"):format(type(callback)))
    end

    callback(...)
  end,
  --
  --[ RunAsync ]
  --
  -- Schedules the given callback function to run asynchronously after a minimal delay.
  --
  RunAsync = function(self, callback, ...)
    if type(callback) ~= "function" then
      error(("Expected type `function` for 'callback', recieved `%s`"):format(type(callback)))
    end

    local args = ...

    C_Timer.After(
      0,
      function()
        callback(args)
      end
    )
  end
}

--
-- ???
--
Export("Core.Task", Task)
