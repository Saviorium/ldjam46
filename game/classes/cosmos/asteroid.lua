Class = require "lib.hump.class"
PhysicsObject = require "game/classes/cosmos/physical_object"
Drop = require "game/classes/cosmos/drop"
Images = require "data/images"

Asteroid = Class {
    __includes = PhysicsObject,
    init = function(self, x, y, angle, hc)
        self.angle = angle
        self.hc = hc
        self:randomize()
        PhysicsObject.init(self, x, y, self.image)
        self.collider:rotate(angle)
        self.collider:move(x - self.width, y - self.height)
        --self:registerCollider(self.hc)
        self.collider.type = 'asteroid'
    end
}


function Asteroid:destroy()
    if self.destroy_func then self.destroy_func(self) end
    self.hc:remove(self.collider)
end

function Asteroid:draw()
    love.graphics.draw(self.image,
                       self.curr_pos.x,
                       self.curr_pos.y, 
                       self.angle, 
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
    table.insert(Loot,Drop(self.curr_pos.x, self.curr_pos.y, math.random(10,100),'iron', table.maxn(Loot)+1, self.hc))
end

function Asteroid.dropIce(self)
    table.insert(Loot,Drop(self.curr_pos.x, self.curr_pos.y, math.random(50,400),'ice', table.maxn(Loot)+1, self.hc))
end

function Asteroid.dropAll(self)
    table.insert(Loot,Drop(self.curr_pos.x+10, self.curr_pos.y+10, math.random(100,200),'iron', table.maxn(Loot)+1, self.hc))
    table.insert(Loot,Drop(self.curr_pos.x-10, self.curr_pos.y-10, math.random(100,500),'ice', table.maxn(Loot)+1, self.hc))
end

function Asteroid:randomize()
    local temp = math.random(0,3)
    local type = math.random(1,5)
    if temp == 0 then
      self.HP   = math.random(10,100)
      self.image = Images['empty_'..type]
      self.collider = self:createPoligon(Images.poligons['asteroid_'..type])
    elseif temp == 1 then
      self.HP   = math.random(100,1000)
      self.destroy_func = self.dropIron
      self.image = Images['iron_'..type]
      self.collider = self:createPoligon(Images.poligons['asteroid_'..type])
    elseif temp == 2 then
      self.HP   = math.random(50,400)
      self.destroy_func = self.dropIce
      self.image = Images['ice_'..type]
      self.collider = self:createPoligon(Images.poligons['asteroid_'..type])
    elseif temp == 3 then
      self.HP   = math.random(1000,10000)
      self.destroy_func = self.dropAll
      self.image = Images['all_'..type]
      self.collider = self:createPoligon(Images.poligons['asteroid_'..type])
    end
end


function Asteroid:createPoligon(object)
    local polygon = {}
    for _, vertex in ipairs(object.polygon) do
        table.insert(polygon, vertex.x*scale)
        table.insert(polygon, vertex.y*scale)
    end
    return self.hc:polygon(unpack(polygon))
end
return Asteroid