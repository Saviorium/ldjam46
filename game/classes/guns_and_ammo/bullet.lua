Class = require "lib.hump.class"
Vector = require "lib.hump.vector"

Bullet = Class {
    __includes = PhysicsObject,
    init = function(self, x, y, image, speed, angle, hc)
        PhysicsObject.init(self, x, y, image)
        self.speed = speed
        self.angle = angle
        self.hc = hc
        self.cur_speed = Vector(speed*math.cos(angle),
                                speed*math.sin(angle))
        self:registerCollider(self.hc)
        self.collider.type = 'bullet'
        self.time_to_live = 3
        self.damage = 50
    end
}

function Bullet:draw()
    love.graphics.draw(self.image,
                       self.curr_pos.x,
                       self.curr_pos.y, 
                       self.angle+0.5*math.pi, 
                       scale, 
                       scale,
                       self.width/2,
                       self.height/2 )
end

function Bullet:update( dt )
  self:move( self.cur_speed )
  if self.time_to_live > 0 then
    self.time_to_live = self.time_to_live - dt
  end
end

return Bullet