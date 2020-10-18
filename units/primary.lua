local addonName, ns = ...

local ApplyUiScale = ns.utility.ApplyUiScale
local stylesheet = ns.stylesheet

local function Shared(self, unit)
	self:RegisterForClicks('AnyUp')
	self:SetScript('OnEnter', UnitFrame_OnEnter)
    self:SetScript('OnLeave', UnitFrame_OnLeave)

    self:SetSize(
        ApplyUiScale(
            stylesheet[unit].width
            + stylesheet.generic.padding * 2
        ),
        ApplyUiScale(
            stylesheet.health.height
            + stylesheet.power.height
            + stylesheet.power.offset
            + stylesheet.generic.padding * 2
        )
    )

    self.colors = ns.colors
    
    ns.elements.AddHealthBar(self, unit, stylesheet[unit].statusbar)    
    ns.elements.AddPowerBar(self, unit, stylesheet[unit].statusbar)
    ns.elements.AddUnitPower(self, unit, stylesheet.power)

    if unit == "player" or unit == "target" then
        ns.elements.AddUnitHealth(self, unit, stylesheet.health)
    else
        ns.elements.AddUnitHealthShort(self, unit, stylesheet.health)
    end
    
    local nameStyle = stylesheet[unit].name
    if nameStyle ~= nil then
        ns.elements.AddUnitName(self, unit, nameStyle)
    end

    local infoStyle = stylesheet[unit].info
    if infoStyle ~= nil then
        ns.elements.AddUnitInfo(self, unit, infoStyle)
    end
end

oUF:RegisterStyle(addonName .. '_Primary', Shared)
