---@meta

---
--- The main API for interacting with the Backbone framework.
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
--- Creates and registers a new plugin using the given identifier.
---
---@alias api.createPlugin
---| fun(identifier: string): plugin
---

---
--- Executes the provided callback function with the provided arguments (optional).
--- The specified identifier is used for error tracking.
---
---@alias api.executeCallback
---| fun(identifier: string, callback: function, arguments?: unknown[])
---

---
--- Executes the provided callback function asynchronously with the provided arguments (optional).
--- The specified identifier is used for error tracking.
---
---@alias api.executeCallbackAsync
---| fun(identifier: string, callback: function, arguments?: unknown[])
---

---
--- Enables use of the storage module for the provided plugin context,
--- binding the specified global variables to internal storage units.
---
---@alias api.useStorage
---| fun(context: plugin, variables: { account?: string, character?: string })
---

---
--- Retrieves a service by its unique identifier.
---
---@alias api.useService
---| fun(identifier: string): unknown
---

---
--- Registers a new service under the specified identifier.
---
---@alias api.provideService
---| fun(identifier: string, object: function|table)
---
