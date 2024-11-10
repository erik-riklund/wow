---@meta

---
--- Represents a "top border" object with texture and shader fields.
---
---@class BackboneTopBorder
---
---@field topBorder Texture
---@field topBorderShader Texture
---

---
--- Represents a "bottom border" object with texture and shader fields.
---
---@class BackboneBottomBorder
---
---@field bottomBorder Texture
---@field bottomBorderShader Texture
---

---
--- Represents a "left border" object with texture and shader fields.
---
---@class BackboneLeftBorder
---
---@field leftBorder Texture
---@field leftBorderShader Texture
---

---
--- Represents a "right border" object with texture and shader fields.
---
---@class BackboneRightBorder
---
---@field rightBorder Texture
---@field rightBorderShader Texture
---

---
--- A comprehensive border object that includes all four side borders. Inherits from `BackboneTopBorder`,
--- `BackboneBottomBorder`, `BackboneLeftBorder`, and `BackboneRightBorder`.
---
---@class BackboneBorders : BackboneTopBorder, BackboneBottomBorder, BackboneLeftBorder, BackboneRightBorder
---
