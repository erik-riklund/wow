local addon, framework = ...

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

local inspect =
  import(
  {
    "debug.inspect"
  }
)

local map, list, frame =
  import(
  {
    "collections.map",
    "collections.list",
    "ui.generic.frame"
  }
)

local _events = list("string")
local _listeners = map("string", "list(function)")
local _frame = frame("augment.events", {hidden = true})

-- ???
