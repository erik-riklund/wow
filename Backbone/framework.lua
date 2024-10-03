local addon, repository = ...

--[[~ Module: Backbone API ~
  Created: 2024/10/01
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/01

  Initializes the core API for the framework.

]]

---
--- The core API for the Backbone framework.
---
_G.backbone = { components = {} }

---
--- The frame used internally to handle invocation of event listeners
--- and continuous execution of asynchronous background tasks.
---
backbone.frame = CreateFrame 'Frame' --[[@as Frame]]

---
--- ?
---
repository.plugin = { id = 'backbone', name = 'Backbone' }

---
--- ?
---
repository.pluginApi = {}
