--[[

  Project: Stem (framework)
  Module: Exception Handling
  Version: 1.0.0

  Description:
  Provides a global `exception` object for handling errors. This module ensures
  that errors are raised with clear and consistent messaging, particularly
  when dealing with argument type mismatches or generic error cases.

  Author(s): Erik Riklund
  Created: 2024/09/19 | Updated: 2024/09/19

  Usage:

  - Call `exception.generic()` for simple errors or
    `exception.type()` for argument type validation errors.

]]

---
--- A global `exception` object that provides utility methods for handling errors.
--- It includes methods for throwing generic errors as well as type mismatch errors.

---
--- @type exception
---
_G.exception = createProtectedProxy {
  --
  -- Throws a generic error message. If additional arguments are provided, the message
  -- will be formatted using `string.format`. This allows for dynamic error messages
  -- based on the input provided.

  generic = function(message, ...)
    error((... and message:format(...)) or message, 3)
  end,

  -- Throws an error when an argument type mismatch occurs. It provides a detailed message
  -- that specifies the label of the argument, the expected type(s), and the received type.
  -- This method is useful for enforcing type checks within functions.

  type = function(label, expected, recieved)
    local message = 'Invalid argument type (%s); expected %s, recieved %s.'
    expected = (type(expected) == 'string' and expected)
      or table.concat(expected --[[@as array<string>]], ' or ')

    error(message:format(label, expected, recieved), 3)
  end,
} --[[@as exception]]
