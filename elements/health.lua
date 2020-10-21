local _, ns = ...

local ApplyUiScale = ns.utility.ApplyUiScale
local stylesheet = ns.stylesheet

local height = ApplyUiScale(stylesheet.health.height)
local padding = ApplyUiScale(stylesheet.generic.padding)
local borderSize = ApplyUiScale(stylesheet.generic.barBorder)

function ns.elements.AddHealthBar(self, unit)
	local health = ns.elements.StatusBar:new(self)

	health:SetHeight(height)
	health:SetBorderSize(borderSize)
	health:SetPoint("TOPLEFT", padding, -padding)
	health:SetPoint("TOPRIGHT", -padding, -padding)
	health.colorHealth = true
	health.colorReaction = unit ~= "player"
	health.frequentUpdates = true

	self.Health = health
end
