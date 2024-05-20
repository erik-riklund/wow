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

local params, required, optional =
  import(
  {
    "type.params",
    "type.params.required",
    "type.params.optional"
  }
)

local _methods = {
  --
  get = function(self, ...)
    local args =
      params(
      {...},
      {
        required("key", self._type["key"])
      }
    )

    return self._content[args.key]
  end,
  --
  set = function(self, ...)
    local args =
      params(
      {...},
      {
        required("key", self._type["key"]),
        required("value", self._type["value"])
      }
    )

    if not self._content[args.key] then
      self._entries = self._entries + 1
    end

    self._content[args.key] = args.value
  end,
  --
  get_type = function(self)
    return ("map(%s, %s)"):format(self._type["key"], self._type["value"])
  end
}

export(
  "collections.map",
  function(...)
    local args =
      params(
      {...},
      {
        required("key_type", "string"),
        required("value_type", "string"),
        optional("initial_content", "table")
      }
    )

    local instance =
      setmetatable(
      {
        _type = {
          key = args.key_type,
          value = args.value_type
        },
        _entries = 0,
        _content = {}
      },
      {__index = _methods}
    )

    if args.initial_content then
      for key, value in pairs(args.initial_content) do
        instance:set(key, value)
      end
    end

    return instance
  end
)
