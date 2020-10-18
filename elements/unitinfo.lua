local _, ns = ...

local CLASSIFICATION_TEXT = {
	rare = "Rare",
	rareelite = "Rare-Elite",
	elite = "Elite",
	worldboss = "Champion"
}

local function isPlayer(unit)
	return UnitIsPlayer(unit)
end

local function isPet(unit)
	return not UnitIsPlayer(unit)
		and (
			UnitPlayerControlled(unit)
			or UnitPlayerOrPetInRaid(unit)
		)
end

local function isFriend(unit)
	return UnitIsFriend('player', unit)
end

local function isEnemy(unit)
	return not UnitIsFriend('player', unit)
end

local function class(unit)
	if UnitIsPlayer(unit) then
		return UnitClass(unit)
			or nil
	else
		local classbase, classindex = UnitClassBase(unit)
		return classbase and GetClassInfo(classindex)
			or nil
	end
end

local function race(unit)
	return UnitRace(unit)
end

local function creature(unit)
	return UnitCreatureFamily(unit)
		or UnitCreatureType(unit)
		or nil
end

local function smartClass(unit)
	if isPlayer(unit)
		or isEnemy(unit)
		and not isPet(unit)
	then
		return class(unit)
	end
	return nil
end

local function smartRace(unit)
	return isPlayer(unit)
		and race(unit)
		or creature(unit)
end

local function druidForm(unit)
	return nil
end

local function classification(unit)
    return CLASSIFICATION_TEXT[UnitClassification(unit)]
end

ns.elements.unitInfo = {
    isPlayer = isPlayer,
    isPet = isPet,
    isFriend = isFriend,
    isEnemy = isEnemy,
    class = class,
    race = race,
    creature = creature,
    smartClass = smartClass,
    smartRace = smartRace,
    druidForm = druidForm,
    classification = classification
}