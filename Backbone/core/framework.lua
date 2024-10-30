---@class Backbone
local context = select(2, ...)

--[[~ Module: Framework ~
  Updated: 2024/10/21 | Author(s): Erik Riklund (Gopher)
]]

---
--- ?
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
--- ?
---
backbone.system = {
  ---
  --- ?
  ---
  expansion = GetExpansionLevel()
}

---
--- An extendable collection of utility functions that assist with common
--- tasks and operations within the framework, promoting code reusability.
---
---
backbone.utilities = {}

---
--- Returns the current version of the framework.
---
--- @return number, number, number "`MAJOR`, `MINOR`, and `PATCH` version numbers."
backbone.getCurrentVersion = function() return string.split('.', version) end
