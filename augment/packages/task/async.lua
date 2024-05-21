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

export(
  "task.async",
  function(callback, ...)
    if type(callback) ~= "function" then
      throw("Expected type `function` for 'callback'")
    end

    local args = ...
    C_Timer.After(
      0,
      function()
        callback(args)
      end
    )
  end
)
