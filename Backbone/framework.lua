--[[~ Module: Backbone API ~
  Created: 2024/10/01
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/10/01

  Provides the core API for the framework, including an internally used frame object.

]]


---
--- The core API for the Backbone framework.
---
_G.backbone = {}

---
--- The frame used internally to handle invocation of event listeners
--- and continuous execution of asynchronous background tasks.
---
backbone.frame = CreateFrame 'Frame' --[[@as Frame]]
