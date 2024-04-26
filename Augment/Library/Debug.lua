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
  ["nil"] = "gray",
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
-- Provides a formatted visual representation of a value, particularly helpful for
-- inspecting tables and arrays.
--
-- Parameters:
--   target: The value to be inspected. This can be any data type, including numbers,
--           strings, booleans, tables, and arrays.
--

function Debug:Inspect(target)
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
-- Provides a detailed, formatted, and recursive inspection of tables and arrays,
-- especially useful for debugging complex data structures.
--
-- Parameters:
--   target: The table or array to be inspected.
--   depth (optional): An internal parameter to track the current level of recursion for formatting purposes.
--   prefix (optional): An internal parameter used to build up key prefixes for nested values.
--

function Debug:InspectRecursive(target, depth, prefix)
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

  local iterator, source = nil, nil
  if is_array then
    iterator, source = ipairs(target)
  else
    iterator, source = pairs(target)
  end

  for key, value in iterator, source do
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
