local ADDON, CORE = ...

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
local Map = CORE.Data.Structures.Map -- create a local reference
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--[ Map:Init ]
--
-- Constructor used to specify expected types and set the initial tree structure.
--
function Map:Init(expected_types, initial_tree)
  --
  local Type = CORE.Type
  local key_type, value_type = unpack(expected_types)
  --
  -- TODO : creation of type validators ...
  --
  if type(initial_tree or {}) ~= "table" then
    error("Expected type `table` for parameter 'initial_tree'")
  end
  --
  self.tree = initial_tree or {}
end

--
--[ Map:Get ]
--
-- ???
--
function Map:Get(key)
  return self.tree[key]
end

--
--[ Map:Set ]
--
-- ???
--
function Map:Set(key, value)
  --
  self.tree[key] = value
end

--
--[ Map:GetIterator ]
--
-- Return an iterator for the current tree.
--
function Map:GetIterator()
  return pairs(self.tree)
end

--
--[ Map:GetKeyCount ]
--
-- Return the number of keys currently present in the table.
--
function Map:GetKeyCount()
  --
  local counter = Number:New()
  --
  for _, _ in self:GetIterator() do
    counter:Increment(1)
  end
  --
  return counter:GetValue()
end
