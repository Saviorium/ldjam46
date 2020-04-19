Class = require "lib.hump.class"
PhysicsObject = require "game/classes/physical_object"

Asteroid = Class {
    __includes = PhysicsObject,
    init = function(self, x, y, angle, image, HP, drop, type)
        PhysicsObject.init(self, x, y, image)
        self.angle = angle
        self.width  = self.image:getWidth()
        self.height = self.image:getHeight()
        self.HP = HP
        self:randomize()
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

function Asteroid:dropIron()

end
function Asteroid:dropIce()

end
function Asteroid:dropAll()

end

function Asteroid:randomize()
  local temp = math.random(0,3)
  if temp == 0 then
    self.HP   = math.random(10,100)
  elseif temp == 1 then
    self.HP   = math.random(100,1000)
    self.destroy_func = self:dropIron()
  elseif temp == 2 then
    self.HP   = math.random(50,400)
    self.destroy_func = self:dropIce()
  elseif temp == 3 then
    self.HP   = math.random(1000,10000)
    self.destroy_func = self:dropAll()
  end
end

return Asteroid