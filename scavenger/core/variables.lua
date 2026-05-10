--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
--   github.com/erik-riklund/wow/scavenger/core (2026)

---@class context
local x = select(2, ...)

--
-- # Saved variables & nested state management
--
-- This module manages the persistence layer of the addon. When the addon is loaded,
-- it binds to WoW's global SavedVariables storage (`__scavenger`) and registers
-- path-based API methods (`get_variable` and `set_variable`) to read and write
-- deeply nested configuration settings safely.
--

local remove_variables_initializer
remove_variables_initializer = scavenger.add_event_hook(
  "ADDON_LOADED", function()
    local variables = __scavenger or {}
    __scavenger = variables -- ensure that the saved variables are persisted.

    --
    -- # API: Path-based getter
    --
    -- Example path: "/settings/general/enable_sound"
    -- Safely traverses the nested tables. If any directory in the path does not exist,
    -- it aborts early and returns `nil` instead of throwing an error.
    --

    scavenger.extend(
      "get_variable", function(path)
        ---@diagnostic disable-next-line: undefined-field
        local steps = { string.split("/", string.sub(path, 2)) }
        local property = table.remove(steps) -- the last element.

        local reference = variables
        for _, current_step in ipairs(steps) do
          if reference[current_step] == nil then
            return nil -- Abort and return `nil` because the nested path branch does not exist.
          end
          reference = reference[current_step]
        end

        return reference[property]
      end
    )

    --
    -- # API: Path-based setter
    --
    -- Example path: "/settings/general/enable_sound"
    -- Traverses the nesting and dynamically creates any missing intermediate
    -- tables along the path before assigning the final value.
    --

    scavenger.extend(
      "set_variable", function(path, value)
        ---@diagnostic disable-next-line: undefined-field
        local steps = { string.split("/", string.sub(path, 2)) }
        local property = table.remove(steps) -- the last element.

        local reference = variables
        for _, current_step in ipairs(steps) do
          if reference[current_step] == nil then
            reference[current_step] = {} -- Auto-create the nested table if it is missing.
          end
          reference = reference[current_step]
        end

        reference[property] = value
      end
    )

    remove_variables_initializer() -- Unregister the hook to free up memory.
  end
)
