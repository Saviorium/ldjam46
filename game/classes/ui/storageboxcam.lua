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
    if motherShip.storage[self.resource].value > 0 and 
       motherShip.storage[self.resource].value < motherShip.storage[self.resource].max/4 then
        self.sprite:setTag('empty')
    elseif motherShip.storage[self.resource].value < motherShip.storage[self.resource].max/2 and 
           motherShip.storage[self.resource].value > motherShip.storage[self.resource].max/4 then
        self.sprite:setTag('some')
    elseif motherShip.storage[self.resource].value < (motherShip.storage[self.resource].max*3)/4 and 
           motherShip.storage[self.resource].value > motherShip.storage[self.resource].max/2 then
        self.sprite:setTag('many')
    elseif motherShip.storage[self.resource].value <= motherShip.storage[self.resource].max and 
           motherShip.storage[self.resource].value > (motherShip.storage[self.resource].max*3)/4 then
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