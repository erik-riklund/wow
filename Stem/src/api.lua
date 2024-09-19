---@type string, context
local addon, context = ...

--[[

  Project: Stem (framework)
  Module: Core API
  Version: 1.0.0

  Author(s): Erik Riklund
  Created: 2024/09/19 | Updated: 2024/09/19

  Description:
  Defines the core API for the Stem framework. This API is wrapped in a protected 
  proxy to ensure the core functions and data cannot be modified. 

  Notes:

  - The global `stem` object provides a protected interface to the framework's core API,
    ensuring the framework's internal state remains intact.

]]

---
--- The core API for the Stem framework, protected by a proxy to prevent modifications.
--- This object provides access to the framework's essential functionality while
--- ensuring its integrity by disallowing direct modifications to the API.

---
--- @type api
---
_G.stem = createProtectedProxy {} --[[@as api]]
