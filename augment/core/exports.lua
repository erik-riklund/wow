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

--
--- ???
--
--- @params
---
--- * module: string       - The identifier for the module that the component is a part of.
--- * component_id: string - A unique identifier (within the specified `module`) for the component.
--- * component: any       - The object that should be registered in the system.
--- * context?: table      - Used to enforce a protection constraint for the component,
---                          only allowing the owner context to import it.
--
_G.export = function(...)
  --
  local module, component_id, component, context =
      declare({ ... }, {
        param("module", "string", { empty = false }),
        param("component_id", "string"),
        param("component", "any"),
        param("context", "table", { optional = true })
      })

  --
end

--
--- ???
--
--- @params
---
--- * module: string    - The identifier for the module that the component is a part of.
--- * components: array - A list of identifiers (strings) specifying which component(s) to import.
--- * context?: table   - Must be supplied to verify ownership of protected components.
--
_G.import = function(...)
  --
  local module, components, context =
      declare({ ... }, {
        param("module", "string"),
        param("components", "array"),
        param("context", "table", { optional = true })
      })

  --
end
