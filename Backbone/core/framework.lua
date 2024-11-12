---@class Backbone
local context = select(2, ...)

--[[~ Framework ~
  Updated: 2024/11/12 | Author(s): Erik Riklund (Gopher)
]]

---
--- An array of functions that integrate various APIs into new plugins.
--- 
---@type array<fun(plugin: Plugin, options?: PluginOptions)>
---
context.apis = {}

---
--- A string representing the current version of the framework,
--- formatted as `MAJOR.MINOR.PATCH`.
---
local version = '1.0.0'

---
--- The core API for the framework, serving as the main entry point
--- for accessing its features and functionalities.
---
_G.backbone = {}

---
--- A module for managing components within the framework, allowing for 
--- organization and extension of various functionalities.
---
backbone.components = {}

---
--- A module containing enumerations used throughout the framework for 
--- improved readability and maintainability of code.
---
backbone.enums = {}

---
--- Provides static system resources.
---
backbone.system = {
  ---
  --- The ID for the current expansion.
  ---
  expansion = GetExpansionLevel(),

  ---
  --- The identifier for the currently active locale.
  ---
  locale = GetLocale()
}

---
--- An extendable collection of utility functions that assist with common
--- tasks and operations within the framework, promoting code reusability.
---
---
backbone.utilities = {}

---
--- An extendable collection of utility functions that provides commonly used
--- functionalities related to the behavior and visual appearance of UI widgets.
---
backbone.widgets = {}

---
--- Returns the current version of the framework.
---
--- @return number, number, number "`MAJOR`, `MINOR`, and `PATCH` version numbers."
backbone.getCurrentVersion = function() return string.split('.', version) end
