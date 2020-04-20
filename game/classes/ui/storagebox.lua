Class = require "lib.hump.class"

StorageBox = Class {
    init = function(self, x, y, resource, storageUnit, shipStorage)
        self.curr_pos = Vector( x, y )
        self.resource = resource
        self.storageUnit = storageUnit
        self.shipStorage = shipStorage
        self:initUI()
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

    love.graphics.setFont(fonts.numbers)
    love.graphics.setColor(1, 0, 0)
    love.graphics.print(
        string.format('%d', math.min(self.storageUnit:getValue(),9999)),
        self.curr_pos.x+48*scale,
        self.curr_pos.y+12*scale,
        0,
        scale,
        scale
    )
end

function StorageBox:draw()
    self:drawBox()
end

return StorageBox