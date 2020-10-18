local _, ns = ...

local ApplyUiScale = ns.utility.ApplyUiScale
local stylesheet = ns.stylesheet

local borderSize = ApplyUiScale(stylesheet.generic.barBorder)
local barTexture = ns.assets.STATUSBAR

function ns.elements.templates.StatusBar(self, unit)
    local bar = CreateFrame("StatusBar", nil, self)
    bar:SetStatusBarTexture(barTexture)

    local bg = bar:CreateTexture(nil, "BACKGROUND")
    bg:SetTexture(barTexture)
    bg:SetVertexColor(0.15, 0.15, 0.15, 0.6)
    bg:SetPoint("TOPLEFT", -borderSize, borderSize)
    bg:SetPoint("TOPRIGHT", borderSize, borderSize)
    bg:SetPoint("BOTTOMLEFT", -borderSize, -borderSize)
    bg:SetPoint("BOTTOMRIGHT", borderSize, -borderSize)

    return bar, bg
end
