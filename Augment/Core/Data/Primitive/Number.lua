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
local Number = CORE.Data.Primitive.Number
--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--~--

--
--[ Number:Init ]
--
-- Constructor used to set the initial value (defaults to '0').
--
function Number:Init(initial_value)
  --
  if type(initial_value or 0) ~= "number" then
    error("Expected type `number` for parameter 'initial_value'")
  end
  --
  self.value = initial_value or 0
end

--
--[ Number:GetValue ]
--
-- Return the current value.
--
function Number:GetValue()
  return self.value
end

--
--[ Number:Add ]
--
-- Add the specified `amount` to the current value.
--
function Number:Add(amount)
  --
  if type(amount) ~= "number" then
    error("Expected type `number` for parameter 'amount'")
  end
  --
  self.value = self.value + amount
end

--
--[ Number:Subtract ]
--
-- Subtract the specified `amount` from the current value.
--
function Number:Subtract(amount)
  --
  if type(amount) ~= "number" then
    error("Expected type `number` for parameter 'amount'")
  end
  --
  self.value = self.value - amount
end

--
--[ Number:Multiply ]
--
-- Multiply the current value using the provided `multiplier`.
--
function Number:Multiply(multiplier)
  --
  if type(multiplier) ~= "number" then
    error("Expected type `number` for parameter 'multiplier'")
  end
  --
  self.value = self.value * multiplier
end

--
--[ Number:Divide ]
--
-- Divide the current value using the provided `divider`.
--
function Number:Divide(divider)
  --
  if type(divider) ~= "number" then
    error("Expected type `number` for parameter 'divider'")
  end
  --
  if divider == 0 then
    error("Expected a non-zero number for parameter 'divider'")
  end
  --
  self.value = self.value / divider
end
