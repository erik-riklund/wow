local ADDON, CORE = ...
local Type = Type
Debug = {}

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

local type_colors = {
  ["undefined"] = "gray",
  ["boolean"] = "olive",
  ["string"] = "yellow",
  ["number"] = "white",
  ["function"] = "teal",
  ["userdata"] = "maroon",
  ["thread"] = "orange",
  ["array"] = "taupe",
  ["table"] = "wheat"
}

--
--- Inspects a value and provides formatted output.
--
-- This function offers type-aware output, with special handling for tables and arrays, 
-- potentially providing recursive inspection. 
--
-- @param target any The value to be inspected.
--

function Debug:Inspect(target)
  --
  local target_type = Type:GetType(target)

  if target_type == "table" or target_type == "array" then
    self:InspectRecursive(target)
    return
  end

  print(
    Markup:Parse(
      "{@" .. type_colors[target_type] .. " ($target_type)} $target",
      {target_type = target_type, target = tostring(target)}
    )
  )
end

--
--- Recursively inspects tables and arrays, providing structured and formatted output.
--
-- This function works in conjunction with `Debug:Inspect` to provide a detailed view of 
-- complex data structures.
--
-- @param target table or array The table or array to be inspected.
-- @param depth number (optional) The current recursion depth (used internally).
-- @param prefix string (optional) A prefix string for the current element (used internally).
--

function Debug:InspectRecursive(target, depth, prefix)
  --
  local target_type = Type:GetType(target)

  if target_type ~= "table" and target_type ~= "array" then
    self:Inspect(target)
    return
  end

  local is_array = target_type == "array"
  local target_color = type_colors[target_type]
  local indent = string.rep(String.Space, 3)
  local base_indent = string.rep(indent, depth or 0)

  local opening_bracket = When(is_array, "[", "(")
  local closing_bracket = When(is_array, "]", ")")

  print(
    base_indent ..
      (prefix or String.Empty) ..
        Markup:Parse(
          "{@" .. target_color .. " $bracket}",
          {
            bracket = opening_bracket
          }
        )
  )

  local function GetIterator()
    if is_array then
      return ipairs(target)
    else
      return pairs(target)
    end
  end
  
  for key, value in GetIterator() do
    --
    local value_type = Type:GetType(value)
    value = (value_type == "string" and ('"%s"'):format(value)) or value

    if value_type == "array" or value_type == "table" then
      local prefix = "{@" .. target_color .. " $key} = "
      self:InspectRecursive(value, (depth or 0) + 1, Markup:Parse(prefix, {key = key}))
    else
      local output = "{@" .. target_color .. " $key} = {@" .. type_colors[value_type] .. " $value}"
      print(base_indent .. indent .. Markup:Parse(output, {key = key, value = tostring(value)}))
    end
  end

  print(
    base_indent ..
      Markup:Parse(
        "{@" .. target_color .. " $bracket}",
        {
          bracket = closing_bracket
        }
      )
  )
end
