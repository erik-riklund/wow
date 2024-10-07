---@type string, Repository
local addon, repository = ...

--[[~ Controller: Graphical User Interface ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

]]

---@type hashmap<string, { main: table, left?: table, right?: table }>
local pages = {}

-- [explain this section]

repository.registerPage = function(name, panels)
  if pages[name] ~= nil then
    backbone.throwError('The page "%s" is not unique.', name) --
  end

  pages[name] = panels
end

-- [explain this section]

repository.setActivePage = function(name)
  for page, panels in pairs(pages) do
    for _, panel in pairs(panels) do
      (panel --[[@as ScriptRegion]]):SetShown(page == name)
    end
  end
end
