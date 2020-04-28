Class = require "lib.hump.class"

StorageBoxCam = Class {
    init = function(self, x, y, resource, storageUnit)
        self.curr_pos = Vector( x, y )
        self.resource = resource
        self.storageUnit = storageUnit
        self:initUI()
        self.sprite = Images[resource..'_storage']
        self.sprite:setTag('empty')
        self.sprite:play()
    end
}


function StorageBoxCam:initUI()
    self.image_back = Images['storageBox']
end

function StorageBoxCam:update(dt)
    self.sprite:update(dt)
    local resourcePercent = 100 * ( motherShip.storage[self.resource].value / motherShip.storage[self.resource].max )
    if resourcePercent < 0.1 then
        self.sprite:setTag('empty')
    elseif resourcePercent < 20 then
        self.sprite:setTag('some')
    elseif resourcePercent < 60 then
        self.sprite:setTag('many')
    else 
        self.sprite:setTag('full')
    end
end

function StorageBoxCam:drawBox()
    self.sprite:draw( self.curr_pos.x, 
                      self.curr_pos.y, 
                      0, 
                      scale, 
                      scale)
end

function StorageBoxCam:draw()
    self:drawBox()
end

return StorageBoxCam