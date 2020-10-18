local _, ns = ...

local tags = oUF.Tags.Methods
local tagEvents = oUF.Tags.Events
local tagSharedEvents = oUF.Tags.SharedEvents

local floor = math.floor
local format = string.format

local unitInfo = ns.elements.unitInfo

local ShortenValue = ns.utility.ShortenValue
local Percent = ns.utility.Percent

local function UnitNameTag(unit)
    return GetUnitName(unit, false)
end

local function UnitLevelTag(unit)
    local level
    if (UnitIsWildBattlePet(unit) or UnitIsBattlePetCompanion(unit)) then
        level = UnitBattlePetLevel(unit)
    else
        level = UnitEffectiveLevel(unit)
    end
    return level < 0 and "??" or level
end

local function UnitClassTag(unit, realUnit)
    local class
    if unitInfo.isPlayer(unit)
        or (
            not unitInfo.isFriend(unit)
            and not unitInfo.isPet(unit)
        )
    then
        class = unitInfo.class(unit)
    else
        class = unitInfo.smartRace(unit)
    end

    local form = unitInfo.druidForm(unit)
    if form then
        class = class .. " (" .. form .. ")"
    end

    return class
end

local function UnitClassificationTag(unit)
    local classification = unitInfo.classification(unit)
    return classification and (' ' .. classification) or nil
end

local function UnitHealthTag(unit)
    local health = UnitHealth(unit)
    return format("%s", ShortenValue(health))
end

local function UnitHealthMaxTag(unit)
    local healthMax = UnitHealthMax(unit)
    return format("%s", ShortenValue(healthMax))
end

local function UnitHealthPercentTag(unit)
	local cur = UnitHealth(unit)
    local max = UnitHealthMax(unit)
    return Percent(cur, max)
end

local function UnitAbsorbTag(unit)
    local absorb = UnitGetTotalAbsorbs(unit)
    return absorb > 0
        and format("%s", ShortenValue(absorb))
        or nil
end

local function UnitSmartPowerTag(unit)
    local cur, max = UnitPower(unit), UnitPowerMax(unit)
	if(max == 0) then return end

	local powerType, powerName = UnitPowerType(unit)
	if powerName == 'MANA' then
		return Percent(cur, max)
    else
        return format("%s", cur)
    end
end

tags["layout:name"] = UnitNameTag
tagEvents["layout:name"] = "UNIT_NAME_UPDATE UNIT_FACTION"
tags["layout:level"] = UnitLevelTag
tagEvents["layout:level"] = "UNIT_LEVEL"
tags["layout:class"] = UnitClassTag
tagEvents["layout:class"] = "UNIT_NAME_UPDATE UNIT_FACTION"
tags["layout:classification"] = UnitClassificationTag
tagEvents["layout:classification"] = "UNIT_CLASSIFICATION_CHANGED"
tags['layout:health'] = UnitHealthTag
tagEvents['layout:health'] = 'UNIT_HEALTH'
tags['layout:healthMax'] = UnitHealthMaxTag
tagEvents['layout:healthMax'] = 'UNIT_MAXHEALTH'
tags['layout:healthPercent'] = UnitHealthPercentTag
tagEvents['layout:healthPercent'] = 'UNIT_HEALTH UNIT_MAXHEALTH'
tags['layout:absorb'] = UnitAbsorbTag
tagEvents['layout:absorb'] = 'UNIT_ABSORB_AMOUNT_CHANGED'
tags['layout:smartPower'] = UnitSmartPowerTag
tagEvents['layout:smartPower'] = 'UNIT_POWER_FREQUENT UNIT_MAXPOWER UNIT_DISPLAYPOWER'
