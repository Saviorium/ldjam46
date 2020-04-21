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
    if self.sprite then 
        self.sprite:update(dt) 
        print(motherShip.storage[self.resource].value, motherShip.storage[self.resource].max)
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