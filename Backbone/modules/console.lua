--[[~ Module: Console ~
  Created: 2024/10/02
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/03

  Provides logging and messaging utilities for the Backbone ecosystem.

]]


local processMarkup = backbone.processMarkup

---
--- ?
---
backbone.console = {
  ---
  --- Prints a message intended for debugging in development mode.
  ---
  ---@param message string
  ---@param variables? hashmap<string, string|number>
  ---
  debug = function(message, variables)
    if not backbone.isProductionMode() then
      print(processMarkup('<color: golden>[Backbone] ' .. message .. '</color>', variables))
    end
  end,

  ---
  --- Prints the provided error message in development mode,
  --- or a generic error message in production mode.
  ---
  ---@param message string
  ---@param variables? hashmap<string, string|number>
  ---
  exception = function(message, variables)
    print(
      (
        not backbone.isProductionMode()
        and processMarkup('<color: saffron>[Backbone] ' .. message .. '</color>', variables)
      )
        or processMarkup(
          '<color: saffron>[Backbone] The framework encountered an internal or plugin-related exception. '
            .. 'You can try "/reload" to check if the problem persists, or use "/backbone development" to '
            .. 'enable more detailed error reporting.</color>'
        )
    )
  end,

  ---
  --- Prints an informational message to the chat frame.
  ---
  ---@param message string
  ---@param variables? hashmap<string, string|number>
  ---
  message = function(message, variables)
    print(processMarkup('<color: vanilla>[Backbone] ' .. message .. '</color>', variables))
  end,
}
