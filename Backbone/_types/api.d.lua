---@meta

---
--- ?
---
---@class api
---
---@field createPlugin          api.createPlugin
---@field executeCallback       api.executeCallback
---@field executeCallbackAsync  api.executeCallbackAsync
---@field useStorage            api.useStorage
---

---
--- ?
---
---@alias api.createPlugin
---| fun(identifier: string): plugin
---

---
--- ?
---
---@alias api.executeCallback
---| fun(identifier: string, callback: function, arguments?: unknown[])
---

---
--- ?
---
---@alias api.executeCallbackAsync
---| fun(identifier: string, callback: function, arguments?: unknown[])
---

---
--- ?
---
---@alias api.useStorage
---| fun(context: plugin, variables: { account?: string, character?: string })
---
