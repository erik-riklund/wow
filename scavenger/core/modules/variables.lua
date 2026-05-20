--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger/core (2026)

---@class context
local x = select(2, ...)

--
-- # Path tokenization helper
--
-- Splits a standardized slash-separated configuration path string into
-- an array of individual keys, stripping the leading slash character.
--

local function split_path(path)
  return { strsplit("/", string.sub(path, 2)) }
end

--
-- # Nested table traversal engine
--
-- Safely walks through deep table structures matching a sequential key sequence.
-- If build mode is enabled, missing intermediate tables are created automatically.
-- If disabled, structural dead-ends cause an immediate early abort returning nil.
--

local function traverse_table(target, steps, build_mode)
  local is_build_mode = build_mode == true
  local property = steps[#steps] -- the last element.

  local reference = target

  if #steps - 1 > 0 then
    for i = 1, #steps - 1 do
      local current_step = steps[i]

      if reference[current_step] == nil then
        if is_build_mode then
          reference[current_step] = {}
        else
          return nil -- Abort and return `nil` because the nested path branch does not exist.
        end
      end

      reference = reference[current_step]
    end
  end

  -- Ensure the final directory node exists before assignment or retrieval in build mode.
  if not reference[property] and is_build_mode then reference[property] = {} end

  return reference[property]
end

--
-- # Persistent state initialization
--
-- Binds global account-wide and character-specific saved variables to local states
-- on addon load, exposing standard unified path APIs to get and set configuration nodes.
--

local remove_variables_initializer
remove_variables_initializer = scavenger.add_event_hook(
  "ADDON_LOADED", function()
    local variables = ScavengerVariables or {}
    ScavengerVariables = variables

    local character_variables = ScavengerCharacterVariables or {}
    ScavengerCharacterVariables = character_variables

    --
    -- # API: Account-wide variable getter
    --
    -- Resolves and extracts values from the global account data store.
    --

    scavenger.extend(
      "get_variable", function(path)
        return traverse_table(variables, split_path(path))
      end
    )

    --
    -- # API: Character-specific variable getter
    --
    -- Resolves and extracts values from the character-bound data store.
    --

    scavenger.extend(
      "get_character_variable", function(path)
        return traverse_table(character_variables, split_path(path))
      end
    )

    --
    -- # API: Account-wide variable setter
    --
    -- Assigns a value to a targeted account-wide path, creating missing child nodes.
    --

    scavenger.extend(
      "set_variable", function(path, value)
        local steps = split_path(path)
        local property = table.remove(steps)
        local target = traverse_table(variables, steps, true)

        target[property] = value
      end
    )

    --
    -- # API: Character-specific variable setter
    --
    -- Assigns a value to a targeted character path, creating missing child nodes.
    --

    scavenger.extend(
      "set_character_variable", function(path, value)
        local steps = split_path(path)
        local property = table.remove(steps)
        local target = traverse_table(character_variables, steps, true)

        DevTools_Dump({ steps, property, target })

        target[property] = value
      end
    )

    remove_variables_initializer() -- Unregister the hook to free up memory.
  end
)
