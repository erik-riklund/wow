---@meta

---
--- Represents the structure used for validating arguments. Each validation includes 
--- the argument label, its value, the expected types, and an optional flag indicating 
--- whether the argument is optional.
---
--- @class argumentValidation
--- 
--- @field label      string  "The label used to identify the argument being validated."
--- @field value      unknown "The actual value of the argument to be validated."
--- @field types      extendedType | array<extendedType> "The expected type(s) of the argument."
--- @field optional?  boolean "Indicates whether the argument is optional. If true, 'undefined' values are allowed."

