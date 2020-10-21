local _, ns = ...

local ORIENTATION = {
    HORIZONTAL = "HORIZONTAL",
    VERTICAL = "VERTICAL"
}

local StatusBar = {}

local metatable = {
    frame = nil,
    statusbar = nil
}

local function ShimMetatable(frame)
    if metatable.statusbar then
        return metatable.statusbar
    end

    metatable.frame = getmetatable(frame)
    metatable.statusbar = {
        __index = function(t, k)
            return StatusBar[k]
                or metatable.frame.__index[k]
        end
    }
    return metatable.statusbar
end

function StatusBar:new(parent)
    local o = CreateFrame('Frame', nil, parent)
    setmetatable(o, ShimMetatable(o))
    
    o.data = {
        orientation = ORIENTATION.HORIZONTAL,
        statusMin = 0,
        statusMax = 100,
        statusValue = 0,
        colorR = 0,
        colorG = 0,
        colorB = 0,
        colorA = 1,
        lastHeight = 0
    }

    local bar = CreateFrame('Frame', nil, o)
    Mixin(bar, BackdropTemplateMixin)
    bar:SetFrameLevel(o:GetFrameLevel() - 1)

    local bg = CreateFrame('Frame', nil, o)    
    Mixin(bg, BackdropTemplateMixin)
    bg:SetFrameLevel(bar:GetFrameLevel() - 1)

    o.frames = {
        bar = bar,
        bg = bg
    }

    o:SetBorderSize(0)
    o:UpdateFrames()
    
    return o
end

function StatusBar:GetMinMaxValues()
    return self.data.statusMin, self.data.statusMax
end

function StatusBar:GetOrientation()
    return self.data.orientation
end

function StatusBar:GetStatusBarColor()
    return {
        r = self.data.colorR,
        g = self.data.colorG,
        b = self.data.colorB,
        a = self.data.colorA
    }
end

function StatusBar:GetStatusBarTexture()
    return nil
end

function StatusBar:GetValue()
    return self.data.statusValue
end

function StatusBar:SetMinMaxValues(min, max)
    self.data.statusMin = min
    self.data.statusMax = max
end

function StatusBar:SetOrientation(orientation)
    self.data.orientation = ORIENTATION[orientation] or self.data.orientation
end

function StatusBar:SetStatusBarColor(r, g, b, a)
    self.data.colorR = r or self.data.colorR
    self.data.colorG = g or self.data.colorG
    self.data.colorB = b or self.data.colorB
    self.data.colorA = a or self.data.colorA
    self:UpdateFrameColors()
end

function StatusBar:SetStatusBarTexture(file, layer)
end

function StatusBar:SetValue(value)
    self.data.statusValue = value
    self:UpdateFrames()
end

function StatusBar:SetBorderSize(borderSize)
    self.data.borderSize = borderSize
    self.frames.bg:SetPoint('TOPLEFT', self, 'TOPLEFT', -borderSize, borderSize)
    self.frames.bg:SetPoint('BOTTOMLEFT', self, 'BOTTOMLEFT', -borderSize, -borderSize)
    self.frames.bg:SetPoint('TOPRIGHT', self, 'TOPRIGHT', borderSize, borderSize)
    self.frames.bg:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', borderSize, -borderSize)
end

function StatusBar:UpdateFrames()
    local width = self:GetWidth()
    local absMax = math.max(
        0,
        self.data.statusMax - self.data.statusMin
    )
    local absValue = math.min(
        absMax,
        math.max(
            0,
            self.data.statusValue - self.data.statusMin
        )
    )
    local perc = absMax > 0
        and absValue / absMax
        or 0
    local offset = (1 - perc) * width

    self.frames.bar:SetPoint('TOPLEFT', self, 'TOPLEFT', 0, 0)
    self.frames.bar:SetPoint('BOTTOMLEFT', self, 'BOTTOMLEFT', 0, 0)
    self.frames.bar:SetPoint('TOPRIGHT', self, 'TOPRIGHT', -offset, 0)
    self.frames.bar:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -offset, 0)
    
    self:UpdateFrameEdge()
end

function StatusBar:UpdateFrameColors()
    self.frames.bar:SetBackdropColor(
        self.data.colorR,
        self.data.colorG,
        self.data.colorB,
        self.data.colorA
    )
    self.frames.bar:SetBackdropBorderColor(
        self.data.colorR,
        self.data.colorG,
        self.data.colorB,
        self.data.colorA
    )
    self.frames.bg:SetBackdropColor(0, 0, 0, 0.5)
    self.frames.bg:SetBackdropBorderColor(0, 0, 0, 0.5)
end

function StatusBar:UpdateFrameEdge()
    local height = self:GetHeight()
    if height == self.data.lastHeight then
        return
    end
    
    local barEdge = height / 2
    self.frames.bar:SetBackdrop({
        bgFile = ns.assets.STATUSBAR_BG,
        edgeFile = ns.assets.STATUSBAR_EDGE,
        edgeSize = barEdge,
        insets = { left = barEdge, right = barEdge, top = barEdge, bottom = barEdge },
        tile = false
    })

    local bgEdge = height / 2 + self.data.borderSize
    self.frames.bg:SetBackdrop({
        bgFile = ns.assets.STATUSBAR_BG,
        edgeFile = ns.assets.STATUSBAR_EDGE,
        edgeSize = bgEdge,
        insets = { left = bgEdge, right = bgEdge, top = bgEdge, bottom = bgEdge },
        tile = false
    })
    
    self.data.lastHeight = height
end

ns.elements.StatusBar = StatusBar