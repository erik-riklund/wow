--  ____
-- / ___|  ___ __ ___   _____ _ __   __ _  ___ _ __
-- \___ \ / __/ _` \ \ / / _ \ '_ \ / _` |/ _ \ '__|
--  ___) | (_| (_| |\ V /  __/ | | | (_| |  __/ |
-- |____/ \___\__,_| \_/ \___|_| |_|\__, |\___|_|
--                                  |___/
-- github.com/erik-riklund/wow/scavenger/rules (2026)

--- @class context
local x = select(2, ...)
local s = x.settings

local function validate_currency(path, target)
  if type(target) ~= "table" then
    error(string.format("The '%s' property must be a table", path))
  end
  if target.copper == nil and target.silver == nil and target.gold == nil then
    error(string.format("The '%s' property must define at least one denomination (copper, silver, or gold)", path))
  end
  if target.copper ~= nil and type(target.copper) ~= "number" then
    error(string.format("The '%s.copper' property must be a number", path))
  end
  if target.silver ~= nil and type(target.silver) ~= "number" then
    error(string.format("The '%s.silver' property must be a number", path))
  end
  if target.gold ~= nil and type(target.gold) ~= "number" then
    error(string.format("The '%s.gold' property must be a number", path))
  end
end

local function validate_quantity(path, target)
  if target == nil then return end
  if type(target) ~= "table" then
    error(string.format("The '%s' property must be a table", path))
  end
  if target.min ~= nil and type(target.min) ~= "number" then
    error(string.format("The '%s.min' property must be a number", path))
  end
  if target.max ~= nil and type(target.max) ~= "number" then
    error(string.format("The '%s.max' property must be a number", path))
  end
end

if type(s) ~= "table" then
  error("The core settings property must be a table")
end

if s.junk ~= nil then
  if type(s.junk) ~= "table" then error("The 'junk' property must be a table") end
  validate_currency("junk.min_value", s.junk.min_value)
  validate_currency("junk.max_value", s.junk.max_value)
end

if s.money ~= nil then
  if type(s.money) ~= "table" then error("The 'money' property must be a table") end
  validate_currency("money.min_value", s.money.min_value)
  validate_currency("money.max_value", s.money.max_value)
end

if s.items ~= nil then
  if type(s.items) ~= "table" then
    error("The 'items' property must be a table")
  end

  for i, item in ipairs(s.items) do
    if type(item) ~= "table" then
      error(string.format("Item at index %d must be a table", i))
    end
    if type(item.id) ~= "number" then
      error(string.format("Item at index %d is missing a valid numeric 'id'", i))
    end
    if item.action ~= nil and type(item.action) ~= "string" then
      error(string.format("Item at index %d has an invalid 'action' type", i))
    end

    validate_quantity(string.format("items[%d].quantity", i), item.quantity)
  end
end

if s.reagents ~= nil then
  if type(s.reagents) ~= "table" then error("The 'reagents' property must be a table") end

  if s.reagents.quality_threshold ~= nil and type(s.reagents.quality_threshold) ~= "number" then
    error("The 'reagents.quality_threshold' property must be a number representing an Enum.ItemQuality")
  end

  if s.reagents.lootable_types ~= nil then
    if type(s.reagents.lootable_types) ~= "table" then
      error("The 'reagents.lootable_types' property must be a table")
    end

    for i, reagent in ipairs(s.reagents.lootable_types) do
      if type(reagent) ~= "table" then
        error(string.format("Reagent type at index %d must be a table", i))
      end
      if type(reagent.id) ~= "number" then
        error(string.format("Reagent type at index %d is missing a valid numeric 'id'", i))
      end
      if reagent.quality_threshold ~= nil and type(reagent.quality_threshold) ~= "number" then
        error(string.format("Reagent type at index %d has an invalid 'quality_threshold'", i))
      end

      validate_quantity(string.format("reagents.lootable_types[%d].quantity", i), reagent.quantity)
    end
  end
end

if s.gear ~= nil and type(s.gear) ~= "table" then
  error("The 'gear' property must be a table")
end
