---@meta

---
--- ?
---
---@class api
---
---@field createPlugin          api.createPlugin
---@field executeCallback       api.executeCallback
---@field executeCallbackAsync  api.executeCallbackAsync
---@field provideService        api.provideService
---@field useService            api.useService
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

---
--- ?
---
---@alias api.useService
---| fun(identifier: string): unknown
---

---
--- ?
---
---@alias api.provideService
---| fun(identifier: string, object: function|table)
---
