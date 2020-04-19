Class = require "lib.hump.class"
PhysicsObject = require "game/classes/physical_object"

BaseShip = Class {
    __includes = PhysicsObject,
    init = function(self, x, y, hc)
        PhysicsObject.init(self, x, y, love.graphics.newImage("data/images/base-ship.png"))
        self.hc = hc
        self:registerCollider(self.hc)
    end
}

function BaseShip:registerCollider(hc)
    PhysicsObject.registerCollider(self, hc)
    self.collider.type = 'solid'
    self.enterCollider = hc:circle(self.curr_pos.x - (self.width*scale)/2, self.curr_pos.y - (self.height*scale)/2, self.width*scale*3)
    self.enterCollider.type = 'enterBase'
end

function BaseShip:onCollide()
end

return BaseShip