--[[

  Project: Backbone (framework)
  Utility: Error Handling
  Version: 1.0.0

  Author(s): Erik Riklund
  Created: 2024/09/22 | Updated: 2024/09/22

  Description:
  Provides a utility function to throw formatted errors. This function allows developers 
  to include additional context by passing arguments to be formatted into the error message.

  Notes:

  - This utility uses `error()` to raise errors with a custom description and formatting.

]]

---
--- Throws a formatted error with a description and optional arguments. If arguments
--- are provided, they are formatted into the description using `string.format`.
---
--- @param description string   "The error description, potentially containing format specifiers."
--- @param ... string | number  "Optional arguments to format into the error description."
---
_G.throwError = function(description, ...) error((... and description:format(...)) or description, 3) end
