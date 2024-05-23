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
  local module, id, component, context =
      declare({ ... }, {
        param("module", "string", { allow_empty = false }),
        param("id", "string", { allow_empty = false }),
        param("component", "any"),
        param("context", "table", { optional = true })
      })

  _exports[module] = _exports[module] or {}

  ensure(_exports[module][id] == nil,
    "Failed to export component to module '%s', the component '%s' already exists", module, id
  )

  _exports[module][id] = { component = component, owner = context }
end

--
--- ???
--
--- @params
---
--- * module: string    - The identifier for the module that the component is a part of.
--- * components: array - An array of identifiers (strings) specifying the component(s) to import.
--- * context?: table   - Must be supplied to verify ownership of protected components.
--
_G.import = function(...)
  --
  local module, components, context =
      declare({ ... }, {
        param("module", "string", { allow_empty = false }),
        param("components", "array", { allow_empty = false }),
        param("context", "table", { optional = true })
      })

  ensure(_exports[module] ~= nil, "Import failed, unknown module '%s'", module)

  --
end
