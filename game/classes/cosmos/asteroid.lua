Class = require "lib.hump.class"
PhysicsObject = require "game/classes/cosmos/physical_object"
Drop = require "game/classes/cosmos/drop"
Images = require "data/images"

Asteroid = Class {
    __includes = PhysicsObject,
    init = function(self, x, y, angle, index, hc)
        self.angle = angle
        self.hc = hc
        self:randomize(x, y)
        PhysicsObject.init(self, x, y, self.image)
        self.collider:rotate(angle)
        self.collider:scale(scale,scale)
        self.collider.type = 'asteroid'
        self.collider.index = index
    end
}


function Asteroid:destroy()
    if self.destroy_func then self.destroy_func(self) end
    self.hc:remove(self.collider)
end

function Asteroid:draw()
  local dx,dy = self.collider:center()
    love.graphics.draw(self.image,
                       self.curr_pos.x,
                       self.curr_pos.y, 
                       self.angle, 
                       scale, 
                       scale,
                       self.width/2,
                       self.height/2 )
    if debug_physics then
        love.graphics.print(self.HP,
                            self.curr_pos.x,
                            self.curr_pos.y
                           )
    end
end

function Asteroid.dropIron(self)
    table.insert(Loot,Drop(self.curr_pos.x, self.curr_pos.y, (self.HP/5) + math.random(10,100),'iron', table.maxn(Loot)+1, self.hc))
end

function Asteroid.dropIce(self)
    table.insert(Loot,Drop(self.curr_pos.x, self.curr_pos.y, (self.HP/2) + math.random(50,200),'ice', table.maxn(Loot)+1, self.hc))
end

function Asteroid.dropAll(self)
    table.insert(Loot,Drop(self.curr_pos.x+10, self.curr_pos.y+10, (self.HP/10) + math.random(100,200),'iron', table.maxn(Loot)+1, self.hc))
    table.insert(Loot,Drop(self.curr_pos.x-10, self.curr_pos.y-10, (self.HP/5) + math.random(100,400),'ice', table.maxn(Loot)+1, self.hc))
end

function Asteroid:update(dt)
    PhysicsObject.update(self, dt)
    self.angle = self.angle + self.rotationSpeed
    self.collider:rotate(self.rotationSpeed)
end

function Asteroid:randomize( x, y )
    local temp = 0 --math.random(0,3)
    local type = math.random(1,5)
    self.rotationSpeed = math.random(-15,15) / 5000
    -- if temp == 0 then
      self.HP   = math.random(10,100)
      self.image = Images['empty_'..type]
      self.collider = self:createPoligon(Images.poligons['asteroid_'..type])
    -- elseif temp == 1 then
    --   self.HP   = math.random(100,1000)
    --   self.destroy_func = self.dropIron
    --   self.image = Images['iron_'..type]
    --   self.collider = self:createPoligon(Images.poligons['asteroid_'..type])
    -- elseif temp == 2 then
    --   self.HP   = math.random(50,400)
    --   self.destroy_func = self.dropIce
    --   self.image = Images['ice_'..type]
    --   self.collider = self:createPoligon(Images.poligons['asteroid_'..type])
    -- elseif temp == 3 then
    --   self.HP   = math.random(500,1500)
    --   self.destroy_func = self.dropAll
    --   self.image = Images['all_'..type]
    --   self.collider = self:createPoligon(Images.poligons['asteroid_'..type])
    -- end
    self.collider:move(x - Images.poligons['asteroid_'..type].x, y - Images.poligons['asteroid_'..type].y)
end


function Asteroid:createPoligon(object)
    local polygon = {}
    for _, vertex in ipairs(object.polygon) do
        table.insert(polygon, vertex.x)
        table.insert(polygon, vertex.y)
    end
    return self.hc:polygon(unpack(polygon))
end
return Asteroid