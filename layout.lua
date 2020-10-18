local addonName, ns = ...

local ApplyUiScale = ns.utility.ApplyUiScale
local stylesheet = ns.stylesheet

oUF:Factory(function(self)
    self:SetActiveStyle(addonName .. "_Primary")

    local player = self:Spawn('player')
    player:SetPoint(
        stylesheet.player.anchor,
        ApplyUiScale(stylesheet.player.posX),
        ApplyUiScale(stylesheet.player.posY - stylesheet.generic.padding)
    )

    local target = self:Spawn('target')
    target:SetPoint(
        stylesheet.target.anchor,
        ApplyUiScale(stylesheet.target.posX),
        ApplyUiScale(stylesheet.target.posY + stylesheet.generic.padding)
    )

    local targettarget = self:Spawn('targettarget')
    targettarget:SetPoint(
        stylesheet.targettarget.anchor,
        target,
        stylesheet.targettarget.relativeAnchor,
        ApplyUiScale(stylesheet.targettarget.posX),
        ApplyUiScale(stylesheet.targettarget.posY)
    )
end) 