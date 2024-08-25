--    ____                      _
--   / ___|___   __ _ ___ _ __ (_)_ __  _ __   ___ _ __
--  | |   / _ \ / _` / __| '_ \| | '_ \| '_ \ / _ \ '__|
--  | |__| (_) | (_| \__ \ |_) | | | | | | | |  __/ |
--   \____\___/ \__, |___/ .__/|_|_| |_|_| |_|\___|_|
--              |___/    |_|

local _, context = ...
--- @cast context core.context

local throw = throw

--#region (framework context imports)

--- @type module.plugins
local plugin_manager = context:import('module/plugins')

--- @type utility.table.immutable
local immutable = context:import('utility/table/immutable')

--#endregion

--
-- The main entry point for Cogspinner, providing access to core functionalities
-- and utilities for plugin development. This API is immutable to prevent accidental
-- modification, ensuring stability and predictability for plugin authors.
--

--- @type API
_G.cogspinner = immutable(
  {
    --
    -- The `plugin` function serves as the primary interface for creating and
    -- registering new plugins within the Cogspinner framework. It encapsulates
    -- the plugin lifecycle management.
    --

    plugin = function(id, options)
      return plugin_manager:create_plugin(id, options)
    end,

    --
    -- The `utility` namespace provides a collection of helper functions and modules
    -- that simplify common tasks and promote code reusability within plugins.
    --

    utility =
    {
      --
      -- The `throw` function is exposed to allow plugins to raise formatted errors
      -- in a consistent manner, facilitating debugging and error handling.
      --

      throw = throw,

      --
      -- The `collection` namespace offers convenient data structures like maps and lists
      -- to help organize and manage plugin data effectively.
      --

      collection =
      {
        --
        -- The `map` function provides a way to create and work with associative tables (dictionaries),
        -- enabling efficient key-value storage and retrieval within plugins.
        --

        map = context:import('utility/collection/map'),

        --
        -- The `list` function provides a way to create and work with ordered collections (arrays),
        -- offering methods for insertion, removal, and other common list operations.
        --

        list = context:import('utility/collection/list')
      },

      --
      -- ?

      table =
      {
        --
        -- The `immutable` function allows plugins to create read-only versions of tables,
        -- preventing accidental modifications and promoting data safety.
        --

        immutable = immutable
      }
    }

  } --[[@as API]]
)
