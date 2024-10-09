---@type string, Repository
local addon, repository = ...

--[[~ Module: App ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  Manages pages within the Backbone application, allowing for page
  registration and switching between active pages. Ensures that pages
  have unique identifiers and controls the visibility of associated panels.

]]

---@type hashmap<string, Page>
local pages = {}

---
--- Registers a new page and its associated panels.
---
repository.registerPage = function(identifier, page)
  if pages[identifier] ~= nil then
    backbone.throwError('Failed to register page "%s" (duplicate identifier)', identifier)
  end

  pages[identifier] = page
end

---
--- Sets the specified page as active, showing its registered panels.
---
repository.setActivePage = function(identifier)
  for _, page in pairs(pages) do
    for _, panel in pairs(page) do
      (panel --[[@as Frame]]):SetShown(page == identifier)
    end
  end
end
