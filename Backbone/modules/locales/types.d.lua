---@meta

---
--- Represents a collection of localized strings,
--- indexed by language codes (e.g., 'enUS').
---
---@class Locale : { [string]: LocalizedStrings }

---
--- Represents a set of localized strings, indexed by keys for easy retrieval.
---
---@class LocalizedStrings : { [string]: string }

---
--- Defines a localized label with a reference to a UI object,
--- a key for localization, and optional variables for dynamic content.
---
---@class LocalizedLabel
---@field object FontString
---@field labelKey string
---@field variables? string[]
