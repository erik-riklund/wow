--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
--   github.com/erik-riklund/wow/scavenger/core (2026)

---@class context
local x = select(2, ...)

---------------------------------------------------------------------
-- ?

local remove_variables_initializer
remove_variables_initializer = Scavenger.add_event_hook(
  "ADDON_LOADED", function()
    local variables = __scavenger or {}
    __scavenger = variables -- ensure that the saved variables are persisted.

    -- ?

    Scavenger.extend(
      "get_variable", function(path)
        ---@diagnostic disable-next-line: undefined-field
        local steps = { string.split("/", string.sub(path, 2)) }
        local property = table.remove(steps) -- the last element.

        local reference = variables
        for _, current_step in ipairs(steps) do
          if reference[current_step] == nil then
            return nil -- ?
          end
          reference = reference[current_step]
        end

        return reference[property]
      end
    )

    -- ?

    Scavenger.extend(
      "set_variable", function(path, value)
        ---@diagnostic disable-next-line: undefined-field
        local steps = { string.split("/", string.sub(path, 2)) }
        local property = table.remove(steps) -- the last element.

        local reference = variables
        for _, current_step in ipairs(steps) do
          if reference[current_step] == nil then
            reference[current_step] = {} -- ?
          end
          reference = reference[current_step]
        end

        reference[property] = value
      end
    )

    remove_variables_initializer() -- cleanup.
  end
)
