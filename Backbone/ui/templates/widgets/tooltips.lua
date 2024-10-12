--[[~ Widget: Tooltips ~
  
  Author(s): Erik Riklund (Gopher)
  Version: 1.0.0 | Updated: ?

  ?

]]

---
--- ?
---
---@param self Frame
---@param lines string[]
---
_G.BackboneTooltipTemplate_OnLoad = function(self, lines)
  local contentFrame = self.contentFrame --[[@as Frame]]

  for index, lineContent in ipairs(lines) do
    local currentLine = contentFrame:CreateFontString(nil, 'OVERLAY', 'BackboneTooltipText')

    currentLine:SetWordWrap(false)
    currentLine:SetText(lineContent)
    currentLine:SetPoint('CENTER')
    currentLine:SetPoint('TOP', contentFrame, 'TOP', 0, -((currentLine:GetHeight() + 1.5) * (index - 1)))

    local currentLineWidth = math.ceil(currentLine:GetWidth() * 1.08)
    if currentLineWidth > contentFrame:GetWidth() then contentFrame:SetWidth(currentLineWidth) end

    contentFrame:SetHeight(contentFrame:GetHeight() + math.ceil(currentLine:GetHeight() + (1.5 - (1.5 / #lines))))
  end

  BackboneTooltipTemplate_UpdateSize(self)
end

---
--- ?
---
---@param self Frame
---
_G.BackboneTooltipTemplate_UpdateSize = function(self)
  local contentFrame = self.contentFrame --[[@as Frame]]
  self:SetSize(contentFrame:GetWidth() + 24, contentFrame:GetHeight() + 16)
end
