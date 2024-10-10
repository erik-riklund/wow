---@type string, Repository
local addon, repository = ...

--[[~ Module: Backbone API ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/03

  Initializes the core API for the framework.

]]

---
--- The core API for the Backbone framework.
---
_G.backbone = { version = '1.0.0' }

---
--- A collection of utility functions provided by Backbone.
---
_G.utilities = {}

---
--- The frame used internally to handle invocation of event listeners
--- and ensure continuous execution of asynchronous background tasks.
---
repository.frame = CreateFrame 'Frame'
