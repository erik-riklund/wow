--[[~ Module: ? ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: 2024/09/30

  ?

  Features:

  - ?

]]

---
--- The API for the Backbone framework.
---
_G.backbone = {}

---
--- The frame used internally to handle invocation of event listeners
--- and execution of asynchronous background tasks.
---
backbone.frame = CreateFrame 'Frame' --[[@as Frame]]
