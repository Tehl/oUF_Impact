local _, ns = ...

ns.stylesheet = {
    scale = GetScreenHeight() / 1440,
    generic = {
        padding = 5,
        barBorder = 2,
        fontName = "Fonts\\FRIZQT__.TTF",
        fontSize = 12,
        fontFlags = ""
    },
    health = {
        height = 15,
        text = {
            fontSize = 13,
            offsetX = 10,
            offsetY = -1
        }
    },
    power = {
        height = 10,
        offset = 12,
        inset = 15,
        text = {
            fontSize = 10,
            offsetX = 10,
            offsetY = 0
        }        
    },
    player = {
        anchor = "BOTTOM",
        posX = 0,
        posY = 200,
        width = 410
    },
    target = {
        anchor = "TOP",
        posX = 0,
        posY = -120,
        width = 550,
        name = {
            fontSize = 20,
            offset = 26
        },
        info = {
            fontSize = 12,
            offset = 4
        }
    },
    targettarget = {
        anchor = "LEFT",
        relativeAnchor = "RIGHT",
        posX = 40,
        posY = 0,
        width = 160,
        name = {
            fontSize = 16,
            offset = 3
        }
    }
}

ns.colors =
    setmetatable(
    {
        disconnected = {0.42, 0.37, 0.32},
        health = {150 / 255, 215 / 255, 34 / 255},
        power = setmetatable(
            {
                MANA   = {98 / 255, 202 / 255, 255 / 255},
                RAGE   = {255 / 255, 98 / 255, 98 / 255},
                ENERGY = {255 / 255, 217 / 255, 98 / 255}
            },
            {__index = oUF.colors.power}
        ),
        reaction = setmetatable(
            {
                {255 / 255, 90 / 255, 90 / 255}, -- HATED
                {255 / 255, 90 / 255, 90 / 255}, -- HOSTILE
                {255 / 255, 90 / 255, 90 / 255}, -- UNFRIENDLY
                {255 / 255, 222 / 255, 0 / 255}, -- NEUTRAL
                {150 / 255, 215 / 255, 34 / 255}, -- FRIENDLY
                {150 / 255, 215 / 255, 34 / 255}, -- HONORED
                {150 / 255, 215 / 255, 34 / 255}, -- REVERED
                {150 / 255, 215 / 255, 34 / 255} -- EXALTED
            },
            {__index = oUF.colors.reaction}
        ),
        tapped = {0.42, 0.37, 0.32}
    },
    {__index = oUF.colors}
)

ns.colors.power[0] = ns.colors.power.MANA
ns.colors.power[1] = ns.colors.power.RAGE
ns.colors.power[3] = ns.colors.power.ENERGY

ns.assets = {
    STATUSBAR = [=[Interface\AddOns\oUF_Impact\assets\textures\statusbar]=]
}
