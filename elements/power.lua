local _, ns = ...

local ApplyUiScale = ns.utility.ApplyUiScale
local stylesheet = ns.stylesheet

local height = ApplyUiScale(stylesheet.power.height)
local inset = ApplyUiScale(stylesheet.power.inset + stylesheet.generic.padding)
local padding = ApplyUiScale(stylesheet.generic.padding)
local borderSize = ApplyUiScale(stylesheet.generic.barBorder)

function ns.elements.AddPowerBar(self, unit)
	local power = ns.elements.StatusBar:new(self)

	power:SetHeight(height)
	power:SetBorderSize(borderSize)
	power:SetPoint("BOTTOMLEFT", inset, padding)
	power:SetPoint("BOTTOMRIGHT", -inset, padding)
	power.colorPower = true
	power.frequentUpdates = unit == "player" or unit == "target"

	self.Power = power
end
