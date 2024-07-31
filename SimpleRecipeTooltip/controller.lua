
-- Simple Recipe Tooltip by Ghuul (2023)

-- This module is inspired by the addon Tidy Recipe Tooltip by LudiusMaximus.
-- @ https://www.curseforge.com/wow/addons/tidy-recipe-tooltip
-- Code heavily reworked and adapted to my own vision.

local T = {};

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
-- Parser used to save all lines in the current tooltip, record line numbers
-- and extract required information from the original tooltip:

function T:GetRecipeLineInfo(TOOLTIP)
    local lines_num = {};
    local recipe_lines = {};
    
    for i = 1, TOOLTIP:NumLines() do
        recipe_lines[i] = {
            ['left-text'] = _G[TOOLTIP:GetName().."TextLeft"..i]:GetText(),
            ['left-RGB'] = {_G[TOOLTIP:GetName().."TextLeft"..i]:GetTextColor()},
            ['right-text'] = _G[TOOLTIP:GetName().."TextRight"..i]:GetText(),
            ['right-RGB'] = {_G[TOOLTIP:GetName().."TextRight"..i]:GetTextColor()}
            }
        
        if not lines_num['bind'] and (string.find(recipe_lines[i]['left-text'], 'Binds when') or string.find(recipe_lines[i]['left-text'], 'Soulbound')) then lines_num['bind'] = i;
        elseif not lines_num['product'] and string.byte(string.sub(recipe_lines[i]['left-text'], 1, 1)) == 10 then lines_num['product'] = i;
        elseif not lines_num['teaches'] and string.find(recipe_lines[i]['left-text'], 'Teaches you') then lines_num['teaches'] = i;
        elseif not lines_num['reagents'] and lines_num['teaches'] and not string.find(recipe_lines[1]['left-text'], 'Formula:') then lines_num['reagents'] = i;
        elseif (lines_num['teaches'] and not lines_num['requires']) and string.find(recipe_lines[i]['left-text'], 'Requires') then lines_num['requires'] = i;
        elseif (lines_num['teaches'] and not lines_num['known']) and string.find(recipe_lines[i]['left-text'], 'Already known') then lines_num['known'] = i; end
    end
    
    return recipe_lines, lines_num;
end

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
-- Fetch the line number and amount for the SELL_PRICE line:

function T:GetMoneyFrameInfo(TOOLTIP)
    if TOOLTIP.shownMoneyFrames then
        for i = 1, TOOLTIP.shownMoneyFrames do
            local frame_name = TOOLTIP:GetName()..'MoneyFrame'..i;
            if _G[frame_name.."PrefixText"]:GetText() == string.format("%s:", SELL_PRICE) then
                local frame_anchor = select(2, _G[frame_name]:GetPoint(1));
                local frame_line = tonumber(string.match(frame_anchor:GetName(), TOOLTIP:GetName().."TextLeft(%d+)"))
                
                return frame_line, _G[frame_name].staticMoney;
            end
        end
    end
end

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
-- Used to easily generate a double-line from our saved line data:

function T:AddDoubleLine(TOOLTIP, line_data)
    TOOLTIP:AddDoubleLine(
        line_data['left-text'],
        line_data['right-text'],
        line_data['left-RGB'][1],
        line_data['left-RGB'][2],
        line_data['left-RGB'][3],
        line_data['right-RGB'][1],
        line_data['right-RGB'][2],
        line_data['right-RGB'][3]
    );
end

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
-- This is the main function that coordinates all the other functions:

function T:Handler(TOOLTIP)
    local num_lines = TOOLTIP:NumLines();
    local tooltip_lines, lines_num = self:GetRecipeLineInfo(TOOLTIP);
    local money_line, money_amount = self:GetMoneyFrameInfo(TOOLTIP);
    
    if not lines_num['teaches'] then return; end
    
    -- clear the tooltip so we can rebuild it:
    TOOLTIP:ClearLines();
    
    -- match the title's color with the item's quality:
    if lines_num['product'] then
        tooltip_lines[1]['left-RGB'] = tooltip_lines[lines_num['product']]['left-RGB'];
        tooltip_lines[1]['right-RGB'] = tooltip_lines[lines_num['product']]['right-RGB'];
    end
    
    -- add the title line:
    self:AddDoubleLine(TOOLTIP, tooltip_lines[1]);
    
    -- add the profession requirement line, if the recipe isn't already known:
    if lines_num['requires'] and not lines_num['known'] then
        if tooltip_lines[lines_num['requires']]['left-RGB'][1] ~= '1' then
            self:AddDoubleLine(TOOLTIP, tooltip_lines[lines_num['requires']]);
        end
    end
    
    -- add 'already known' line if available:
    if lines_num['known'] then
        tooltip_lines[lines_num['known']]['left-RGB'] = {nil,nil,nil};
        self:AddDoubleLine(TOOLTIP, tooltip_lines[lines_num['known']]);
    end
    
    -- add the bindings-type line, if it's not BoE:
    if lines_num['bind'] and not string.find(tooltip_lines[lines_num['bind']]['left-text'],'when equipped') then
        TOOLTIP:AddLine(tooltip_lines[lines_num['bind']]['left-text'], .86,.87,.88);
    end
    
    -- add any remaining lines:
    for i = 2, (lines_num['product'] or lines_num['teaches'])-1 do
        if not tContains({lines_num['known'],lines_num['bind'],lines_num['requires']}, i) then
            self:AddDoubleLine(TOOLTIP, tooltip_lines[i]);
        end
    end
    
    -- add an empty line before the teaches line:
    TOOLTIP:AddLine(' ');
    TOOLTIP:AddLine(tooltip_lines[lines_num['teaches']]['left-text'], 0,1,0);
    
    -- print the reagents, if needed:
    if lines_num['reagents'] then
        local reagent_line = tooltip_lines[lines_num['reagents']];
        reagent_line['left-text'] = 'Reagents: '..reagent_line['left-text'];
        local R,G,B = unpack(reagent_line['left-RGB']);
        
        TOOLTIP:AddLine(reagent_line['left-text'], R,G,B, true);
    end
    
    -- this will add lines from other addons to the end of the tooltip:
    for i = (lines_num['known'] or lines_num['requires'] or lines_num['reagents'] or lines_num['teaches'])+1, #tooltip_lines-1 do
        self:AddDoubleLine(TOOLTIP, tooltip_lines[i]); 
    end
    
    -- print the money frame, if available:
    if money_amount then
        TOOLTIP:AddLine(' ');
        SetTooltipMoney(TOOLTIP, money_amount, nil, string.format("%s:", SELL_PRICE));
    end
end

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
--
-- Our hook-function that relays a tooltip to the handler:

function RecipeTooltipRelay(TOOLTIP)
    if TOOLTIP:GetName() == 'GameTooltip' then T:Handler(TOOLTIP); end
end

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, RecipeTooltipRelay)