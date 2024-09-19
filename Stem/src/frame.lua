---@type string, context
local addon, context = ...

--[[

  Project: Stem (framework)
  Module: Frame Management
  Version: 1.0.0

  Author(s): Erik Riklund
  Created: 2024/09/19 | Updated: 2024/09/19

  Description:
  Creates a frame and exposes it through the context, making it accessible to other 
  parts of the framework. The frame is set to be shown by default.

  Notes:

  - This frame is registered within the context under the identifier "frame".

]]

---
--- Creates a basic frame and exposes it through the context under the identifier 'frame'.
--- The frame is shown by default, ensuring it's `OnUpdate` script is executed properly.
---
local frame = CreateFrame 'Frame' --[[@as Frame]]

---
--- Sets the frame to be visible immediately after creation.
---
frame:SetShown(true)

---
--- Exposes the created frame to the context, allowing other parts of the framework
--- to reference it by the identifier 'frame'.
---
context:expose('frame', frame)
