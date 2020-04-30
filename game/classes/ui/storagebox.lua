Class = require "lib.hump.class"
StorageBoxCam = require "game.classes.ui.storageboxcam"

StorageBox = Class {
    init = function(self, x, y, resource, storageUnit)
        self.curr_pos = Vector( x, y )
        self.resource = resource
        self.storageUnit = storageUnit
        self:initUI()
        self.storageScreen = Peachy.new("data/images/ui/big-tablo-sheet.json", Images['bigscreen_alert'], "normal")
        self.storageBoxCam = StorageBoxCam(x, y, resource, storageUnit)
    end
}

function StorageBox:initUI()
    self.image_resource = Images[self.resource]
end

function StorageBox:update(dt)
    self.storageBoxCam:update(dt)
    self.storageScreen:update(dt/4)
end

function StorageBox:changeTag(level, min, mid)
    if self.storageScreen.tagName ~= "alert" and level <= mid and  math.modf(level) > min then
        self.storageScreen:setTag("alert")
    elseif self.storageScreen.tagName ~= "empty" and math.modf(level) == min then
        self.storageScreen:setTag("empty")
    elseif self.storageScreen.tagName ~= "normal" and level > mid then
        self.storageScreen:setTag("normal")
    end
end

function StorageBox:drawBox()
    self.storageBoxCam:draw()
    local level = self.storageUnit:getLevel()*100
    if self.resource == "oxygen" then
        self:changeTag(level, 0, 50)
    end
    if self.resource == "water" then
        self:changeTag(level, 0, 10)
    end
    if self.resource == "foodVeg" then
        self:changeTag(level, 0, 2)
    end
    self.storageScreen:draw(self.curr_pos.x+45*scale, self.curr_pos.y+9*scale, 0, scale, scale)
    love.graphics.setFont(fonts.numbers)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(
        string.format('%4.f', math.clamp(0, self.storageUnit:getValue(), 9999)),
        self.curr_pos.x+48*scale,
        self.curr_pos.y+12*scale,
        0,
        scale,
        scale
    )
    love.graphics.draw(
        self.image_resource,
        self.curr_pos.x+97*scale,
        self.curr_pos.y+3*scale, 
        0,
        scale,
        scale
    )
end

function StorageBox:draw()
    self:drawBox()
end

return StorageBox