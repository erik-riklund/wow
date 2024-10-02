--[[~ Module: ? ~
  Created: 2024/10/02
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

  Features:

  - ?

]]

---
--- ?
---
---@param message string
---@param ... string|number
---
_G.throw = function(message, ...)
  if not backbone.isProductionMode() then
    error((... and string.format(message, ...) or message), 3)
  end

  backbone.console.exception(
    'The framework encountered an internal or plugin-related exception. You can try "/reload" to check if '
      .. 'the problem persists, or use "/backbone development" to enable more detailed error reporting.'
  )
end
