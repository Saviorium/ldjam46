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
        self.drop = drop
        self.type = type
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

function Asteroid:randomize()
  local temp = math.random(0,3)
  if temp == 0 then
    self.type = 'empty'
    self.HP = math.random(10,100)
    self.drop = 0
  elseif temp == 1 then
    self.type = 'iron'
    self.HP   = math.random(100,1000)
    self.drop = math.random(10,100)
  elseif temp == 2 then
    self.type = 'ice'
    self.HP   = math.random(50,400)
    self.drop = math.random(10,100)
  elseif temp == 3 then
    self.type = 'all'
    self.HP   = math.random(1000,10000)
    self.drop = math.random(10,100)

  end

return Asteroid