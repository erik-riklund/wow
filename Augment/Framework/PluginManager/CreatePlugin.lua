local ADDON, CORE = ...
local T = Type

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
local EventHandler = CORE.EventHandler
local PluginManager = CORE.PluginManager
local Plugins = PluginManager.Plugins
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--- Registers a new plugin with the system.
--
-- This function enforces unique plugin identifiers and initializes the plugin's core context.
-- It also dispatches a "PLUGIN_ADDED" event to notify other parts of the system.
--
-- @param id string The unique identifier of the plugin.
-- @param context table A table that will serve as the plugin's context. 
-- @throws error If a plugin with the same 'id' already exists.
--

CreatePlugin = function(id, context)
  --
  local id = T:Check("id", id, T:String())
  local context = T:Check("context", context, T:Table())

  if Table:HasKey(Plugins, id) then
    Throw("Unable to register plugin '$id' due to a non-unique identifier", {id = id})
  end

  context.id = id

  -- what do we need to add to the context here? anything..?

  EventHandler:Dispatch("PLUGIN_ADDED", context)
end
