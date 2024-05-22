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

local _exports = {}

_G.export = function(...)
  local args = declare({ ... }, {
    { name = "context",      type = "table" },
    { name = "module",       type = "string" },
    { name = "component_id", type = "string" },
    { name = "component",    type = "any" },
    { name = "protected",    type = "boolean", default = false }
  })

  -- ???
end

_G.import = function(...)
  local args = declare({ ... }, {
    { name = "context",    type = "table" },
    { name = "module",     type = "string" },
    { name = "components", type = "array" }
  })

  -- ???
end
