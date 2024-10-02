--[[~ Module: Console ~
  Created: 2024/10/02
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

  Features:

  - ?

]]

local processMarkup = backbone.processMarkup

---
--- ?
---
backbone.console = {
  ---
  --- ?
  ---
  ---@param message string
  ---@param variables? hashmap<string, string|number>
  ---
  debug = function(message, variables)
    print(processMarkup('<color: golden>[Backbone] ' .. message .. '</color>', variables))
  end,

  ---
  --- ?
  ---
  ---@param message string
  ---@param variables? hashmap<string, string|number>
  ---
  exception = function(message, variables)
    print(processMarkup('<color: saffron>[Backbone] ' .. message .. '</color>', variables))
  end,

  ---
  --- ?
  ---
  ---@param message string
  ---@param variables? hashmap<string, string|number>
  ---
  message = function(message, variables)
    print(processMarkup('<color: vanilla>[Backbone] ' .. message .. '</color>', variables))
  end,
}
