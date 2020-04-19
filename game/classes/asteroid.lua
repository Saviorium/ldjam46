Class = require "lib.hump.class"
PhysicsObject = require "game/classes/physical_object"
Iron = require "game/classes/iron"
Ice = require "game/classes/ice"

Asteroid = Class {
    __includes = PhysicsObject,
    init = function(self, x, y, angle, HP, drop, type)
        self.angle = angle
        self.HP = HP
        self:randomize()
        PhysicsObject.init(self, x, y, self.image)
        self:registerCollider(HC)
    end
}


function Asteroid:destroy()
    self:destroy_func()
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
end

function Asteroid:dropIron()
  table.insert(Loot,Iron(self.curr_pos.x, self.curr_pos.y, math.random(10,100)))
end
function Asteroid:dropIce()
  table.insert(Loot,Ice(self.curr_pos.x, self.curr_pos.y, math.random(50,400)))

end
function Asteroid:dropAll()
  table.insert(Loot,Iron(self.curr_pos.x, self.curr_pos.y, math.random(100,200)))
  table.insert(Loot,Ice(self.curr_pos.x, self.curr_pos.y, math.random(100,500)))
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

return Asteroid