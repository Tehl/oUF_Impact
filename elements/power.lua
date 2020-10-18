local _, ns = ...

local ApplyUiScale = ns.utility.ApplyUiScale
local stylesheet = ns.stylesheet

local height = ApplyUiScale(stylesheet.power.height)
local inset = ApplyUiScale(stylesheet.power.inset + stylesheet.generic.padding)
local padding = ApplyUiScale(stylesheet.generic.padding)

function ns.elements.AddPowerBar(self, unit)
	local power, bg = ns.elements.templates.StatusBar(self, unit)

	power:SetHeight(height)
	power:SetPoint("BOTTOMLEFT", inset, padding)
	power:SetPoint("BOTTOMRIGHT", -inset, padding)
	power.colorPower = true
	power.frequentUpdates = unit == "player" or unit == "target"

	self.Power = power
end
