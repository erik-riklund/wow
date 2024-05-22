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

local _modules = {
  public = {}, protected = {}
}

--
--[ ??? ]--

local load = function()
end

--
--[ ??? ]--

_G.export = function(...)
  local args = params({ ... },
  {
    required("context", "table"),
    required("module", "string"),
    required("component_id", "string"),
    required("component", "any"),

    optional("access_level", "string", "public")
  })

  -- ???
end

--
--[ ??? ]--

_G.import = function(...)
  local args = params({ ... }, {
    required("context", "table"),
    required("module", "string"),
    required("components", { "string", "table" })
  })

  -- ???
end

--
--[ ??? ]--

_C.context.extend(
  {
    export = function(self, module, component, access_level)
      export(self, module, component, access_level)
    end,

    import = function(self, module, components)
      return import(self, module, components)
    end
  }
)
