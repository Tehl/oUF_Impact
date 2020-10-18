local _, ns = ...

local ApplyUiScale = ns.utility.ApplyUiScale
local stylesheet = ns.stylesheet

function ns.elements.AddText(self, parent, text, size, flags, font)
    local frame = parent or self
    local fontName = font or stylesheet.generic.fontName
    local fontSize = size or stylesheet.generic.fontSize
    local fontFlags = flags or stylesheet.generic.fontFlags

    local fontString = frame:CreateFontString(nil, "OVERLAY")
    fontString:SetFont(fontName, fontSize)
    fontString:SetShadowColor(0, 0, 0, 1)
    fontString:SetShadowOffset(1, -1)

    self:Tag(fontString, text)

    return fontString
end

function ns.elements.AddUnitName(self, unit, style)
    local unitName = ns.elements.AddText(
        self,
        nil,
        "[layout:name]",
        style.fontSize
    )
    unitName:SetPoint("BOTTOM", self, "TOP", 0, ApplyUiScale(style.offset))
end

function ns.elements.AddUnitInfo(self, unit, style)
    local infoText = ns.elements.AddText(
        self,
        nil,
        "Lv. [layout:level][layout:classification] [layout:class]",
        style.fontSize
    )
    infoText:SetPoint("BOTTOM", self, "TOP", 0, ApplyUiScale(style.offset))
    infoText:SetTextColor(1, 1, 1, 0.7)
end

function ns.elements.AddUnitHealth(self, unit)
    local style = stylesheet.health.text
    local offsetX = ApplyUiScale(style.offsetX)
    local offsetY = ApplyUiScale(style.offsetY)

    ns.elements.AddText(
        self,
        self.Health,
        "[layout:absorb]",
        style.fontSize
    ):SetPoint("LEFT", self.Health, "LEFT", offsetX, offsetY)

    ns.elements.AddText(
        self,
        self.Health,
        "[layout:health]",
        style.fontSize
    ):SetPoint("CENTER", self.Health, "CENTER", 0, offsetY)

    ns.elements.AddText(
        self,
        self.Health,
        "[layout:healthPercent]",
        style.fontSize
    ):SetPoint("RIGHT", self.Health, "RIGHT", -offsetX, offsetY)
end

function ns.elements.AddUnitHealthShort(self, unit)
    local style = stylesheet.health.text
    local offsetX = ApplyUiScale(style.offsetX)
    local offsetY = ApplyUiScale(style.offsetY)

    ns.elements.AddText(
        self,
        self.Health,
        "[layout:healthPercent]",
        style.fontSize
    ):SetPoint("RIGHT", self.Health, "RIGHT", -offsetX, offsetY)
end

function ns.elements.AddUnitPower(self, unit)
    local style = stylesheet.power.text
    local offsetX = ApplyUiScale(style.offsetX)
    local offsetY = ApplyUiScale(style.offsetY)

    ns.elements.AddText(
        self,
        self.Power,
        "[layout:smartPower]",
        style.fontSize
    ):SetPoint("RIGHT", self.Power,"RIGHT", -offsetX, offsetY)
end