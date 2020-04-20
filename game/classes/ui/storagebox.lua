Class = require "lib.hump.class"

StorageBox = Class {
    init = function(self, x, y, resource, storageUnit)
        self.curr_pos = Vector( x, y )
        self.resource = resource
        self.storageUnit = storageUnit
        self:initUI()
        self.storageScreen = Images['bigscreen']
    end
}

function StorageBox:initUI()
    self.image_back = Images['storageBox']
    self.image_resource = Images[self.resource]
end

function StorageBox:update(dt)
end

function StorageBox:drawBox()
    love.graphics.draw(self.image_back,
                       self.curr_pos.x,
                       self.curr_pos.y,
                       0, 
                       scale, 
                       scale)
    love.graphics.draw(
        self.storageScreen,
        self.curr_pos.x+45*scale,
        self.curr_pos.y+9*scale, 
        0, 
        scale, 
        scale
    )
    love.graphics.setFont(fonts.numbers)
    love.graphics.print(
        string.format('%d', math.min(self.storageUnit:getValue(),9999)),
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