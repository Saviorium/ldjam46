Class = require "lib.hump.class"
StorageBoxCam = require "game.classes.ui.storageboxcam"

StorageBox = Class {
    init = function(self, x, y, resource, storageUnit)
        self.curr_pos = Vector( x, y )
        self.resource = resource
        self.storageUnit = storageUnit
        self:initUI()
        self.storageScreen = Images['bigscreen']
        self.storageBoxCam = StorageBoxCam(x, y, resource, storageUnit)
    end
}

function StorageBox:initUI()
    self.image_resource = Images[self.resource]
end

function StorageBox:update(dt)
    self.storageBoxCam:update(dt)
end

function StorageBox:drawBox()
    self.storageBoxCam:draw()
    love.graphics.draw(
        self.storageScreen,
        self.curr_pos.x+45*scale,
        self.curr_pos.y+9*scale, 
        0, 
        scale, 
        scale
    )
    love.graphics.setFont(fonts.numbers)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(
        string.format('%4.f', math.min(self.storageUnit:getValue(),9999)),
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