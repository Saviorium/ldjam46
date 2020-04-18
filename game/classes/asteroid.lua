Class = require "lib.hump.class"
PhysicsObject = require "game/classes/physical_object"

Asteroid = Class {
    __includes = PhysicsObject,
    init = function(self, x, y, angle, image)
        PhysicsObject.init(self, x, y, image)
        self.angle = angles
    end
}

function Asteroid:draw()
    love.graphics.draw(self.image,
                       self.curr_pos.x,
                       self.curr_pos.y, 
                       self.angle/math.pi + math.pi/2, 
                       scale, 
                       scale,
                       self.width/2,
                       self.height/2 )
end

return Asteroid