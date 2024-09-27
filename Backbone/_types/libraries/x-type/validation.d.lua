---@meta

---
--- Represents a validation rule consisting of the rule itself and the associated value.
--- The first entry is a string that describes the validation rule (identifier, expected type,
--- and marking it as optional), while the second value holds the related value, which can be
--- of any type. This is primarily used to validate function arguments.
---
---@alias xtype.validation { [1]: string, [2]: unknown }
---
