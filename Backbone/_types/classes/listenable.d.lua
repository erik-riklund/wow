---@meta

---
--- Represents an entity that can register, invoke, and manage listeners. The `listenable` 
--- object handles listener registration, asynchronous execution, and removal by identifier.
---
--- @class listenable
--- @field listeners? listener[] "A list of registered listeners, each containing a callback, identifier, and optional persistence flag."
--- 
--- @field invokeListeners  fun(self: listenable, arguments?: unknown[], executeAsync?: boolean) "Invokes all registered listeners, passing the provided arguments and optionally executing them asynchronously."
--- @field registerListener fun(self: listenable, listener: listener) "Registers a new listener, including its callback, identifier, and optional persistence flag."
--- @field removeListener   fun(self: listenable, identifier: string) "Removes a listener by its unique identifier."
---

---
--- Represents a listener that can be registered with a `listenable` object. Each listener 
--- includes a callback function, a unique identifier for managing the listener, and an 
--- optional persistence flag.
---
--- @class listener
--- @field identifier  string    "A unique identifier for the listener, used for removing or managing the listener."
--- @field callback    function  "The function to be executed when the listener is triggered."
--- @field persistent? boolean   "If `false`, the listener will be removed after it is invoked once."

