local addon, framework = ...

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

local params, required, map, list =
    import(
      {
        "type.params",
        "type.params.required",
        "collections.map",
        "collections.list"
      }
    )

local _reserved = map("string", "string")
local _listeners = map("string", "list(function)")

--
--[ ??? ]--

framework.channel = {

  --[[ channel: string, callback: function ]]
  listen = function(channel, callback)
    _listeners[channel] = _listeners[channel] or list("function")
    _listeners[channel]:push(callback)
  end,

  --[[ channel: string, args[]: any ]]
  dispatch = function(channel, ...)
    if _listeners[channel] and _listeners[channel]:any() then
      local event = _listeners[channel]

      local count = event:count()
      for i = 1, count do
        framework.callbacks.register(event:at(i), { ... })
      end
    end
  end
}

--
--[ ??? ]--

local api = {
  --[[ ??? ]]
  reserve = function(...)
    local args = params({ ... }, { required("channels", "table") })
  end
}

--
--[ ??? ]--

framework.channel.listen(
  "PLUGIN_ADDED",
  function(context)
    context.channel = setmetatable({}, { __index = api })
  end
)
