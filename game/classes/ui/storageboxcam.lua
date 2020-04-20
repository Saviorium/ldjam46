Class = require "lib.hump.class"

StorageBoxCam = Class {
    init = function(self, x, y, resource, storageUnit)
        self.curr_pos = Vector( x, y )
        self.resource = resource
        self.storageUnit = storageUnit
        self:initUI()
    end
}


function StorageBoxCam:initUI()
    self.image_back = Images['storageBox']
end

function StorageBoxCam:update(dt)
end

function StorageBoxCam:drawBox()
    love.graphics.draw(
        self.image_back,
        self.curr_pos.x,
        self.curr_pos.y,
        0, 
        scale, 
        scale
    )
end

function StorageBoxCam:draw()
    self:drawBox()
end

return StorageBoxCam