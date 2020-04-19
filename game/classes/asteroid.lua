Class = require "lib.hump.class"
PhysicsObject = require "game/classes/physical_object"
Drop = require "game/classes/drop"

Asteroid = Class {
    __includes = PhysicsObject,
    init = function(self, x, y, angle, hc)
        self.angle = angle
        self:randomize()
        PhysicsObject.init(self, x, y, self.image)
        self.hc = hc
        self:registerCollider(self.hc)
        self.collider.type = 'asteroid'
    end
}


function Asteroid:destroy()
  for index, asteroid in pairs(Asteroids) do
    if asteroid.curr_pos.x == self.curr_pos.x and
       asteroid.curr_pos.y == self.curr_pos.y then
      Asteroids[index] = nil
    end
  end
  if self.destroy_func then self.destroy_func(self) end
  self.hc:remove(self.collider)
end

function Asteroid:draw()
    love.graphics.draw(self.image,
                       self.curr_pos.x,
                       self.curr_pos.y, 
                       self.angle/math.pi + math.pi/2, 
                       scale, 
                       scale,
                       self.width/2,
                       self.height/2 )
    love.graphics.print(self.HP,
                        self.curr_pos.x,
                        self.curr_pos.y
                       )
end

function Asteroid.dropIron(self)
  table.insert(Loot,Drop(self.curr_pos.x, self.curr_pos.y, math.random(10,100),'iron', self.hc))
end

function Asteroid.dropIce(self)
  table.insert(Loot,Drop(self.curr_pos.x, self.curr_pos.y, math.random(50,400),'ice', self.hc))

end

function Asteroid.dropAll(self)
  table.insert(Loot,Drop(self.curr_pos.x+10, self.curr_pos.y+10, math.random(100,200),'iron', self.hc))
  table.insert(Loot,Drop(self.curr_pos.x-10, self.curr_pos.y-10, math.random(100,500),'ice', self.hc))
end

function Asteroid:randomize()
  local temp = math.random(0,3)
  if temp == 0 then
    self.HP   = math.random(10,100)
    self.image = love.graphics.newImage('data/images/asteroid/empty_'..(math.random(1,5))..'.png')
  elseif temp == 1 then
    self.HP   = math.random(100,1000)
    self.destroy_func = self.dropIron
    self.image = love.graphics.newImage('data/images/asteroid/iron_'..(math.random(1,5))..'.png')
  elseif temp == 2 then
    self.HP   = math.random(50,400)
    self.destroy_func = self.dropIce
    self.image = love.graphics.newImage('data/images/asteroid/ice_'..(math.random(1,5))..'.png')
  elseif temp == 3 then
    self.HP   = math.random(1000,10000)
    self.destroy_func = self.dropAll
    self.image = love.graphics.newImage('data/images/asteroid/all_'..(math.random(1,5))..'.png')
  end
end

function Asteroid:onCollide()
    for shape, delta in pairs(self.hc:collisions(self.collider)) do
      if shape.type == 'bullet' then 
        self.HP = self.HP - 100
        if self.HP < 0 then
          self:destroy()
        end
        Bullets_handler.bullets_on_screen[shape.index] = nil
        self.hc:remove(shape)
      end
    end
end

return Asteroid