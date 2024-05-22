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

local params, required, optional = import({
  "type.params", "type.params.required", "type.params.optional"
})

local _methods =
{
  at = function(self, ...)
    local args = params({ ... }, {
      required("index", "number")
    })

    return self._values[args.index]
  end,

  push = function(self, ...)
    local args = params({ ... }, {
      required("value", self._type)
    })

    table.insert(self._values, args.value)
  end,

  any = function(self)
    return #self._values > 0
  end,

  contains = function(self, ...)
    local args = params({ ... }, {
      required("search_value", self._type)
    })

    local n = #self._values
    for index = 1, n do
      if self._values[index] == args.search_value then
        return index
      end
    end

    return -1
  end,

  count = function(self)
    return #self._values
  end,

  get_type = function(self)
    return ("list(%s)"):format(self._type)
  end
}

export(
  "collections.list",

  function(...)
    local args = params({ ... }, {
      required("expected_type", "string"),
      optional("initial_values", "table")
    })

    local instance = setmetatable(
      { _values = {}, _type = args.expected_type }, { __index = _methods }
    )

    if args.initial_values then
      local n = #args.initial_values
      if n > 0 then
        for i = 1, n do
          instance:push(args.initial_values[i])
        end
      end
    end

    return instance
  end
)
