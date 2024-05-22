local _, _C = ...

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

--
--[ ??? ]--

local _methods = {}

--
--[ ??? ]--

local handler = function(self, id)
  local method = _methods[id]

  if method then
    return function(_, ...)
      return method(self._context, ...)
    end
  end
end

--
--[ ??? ]--

_C.context =
{
  extend = function(...)
    local args = params({ ... }, {
      required("methods", "table")
    })

    for id, method in pairs(args.methods) do
      if _methods[id] ~= nil then
        throw("Unable to add plugin extension method '%s' as it already exists", id)
      end

      _methods[id] = method
    end
  end,

  wrap = function(...)
    local args = params({ ... }, {
      required("context", "table")
    })

    args.context.api = setmetatable(
      { _context = args.context }, { __index = handler }
    )
  end
}
