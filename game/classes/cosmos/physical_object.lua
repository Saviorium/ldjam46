Class = require "lib.hump.class"
Vector = require "lib.hump.vector"

PhysicsObject = Class {
    init = function(self, x, y, image)
        self.curr_pos = Vector( x, y )
        self.cur_speed = Vector( 0, 0)
        self.image = image
        self.height = self.image:getHeight()
        self.width  = self.image:getWidth()
    end,
    minGroundNormal = 0.05,
    minMove         = 0.01
}

function PhysicsObject:registerCollider(hc_instance)
  self.collider = hc_instance:rectangle(self.curr_pos.x - (self.width*scale)/2, self.curr_pos.y - (self.height*scale)/2, self.width*scale, self.height*scale)
end

function PhysicsObject:update( dt )
  if self.collider then
    self:move( self.cur_speed )
    self:onCollide()
  end
end

function PhysicsObject:move( moveVector )
  self.curr_pos = self.curr_pos + moveVector
  self.collider:move(moveVector:unpack())
end

function PhysicsObject:draw()
    love.graphics.draw(self.image,
                       self.curr_pos.x,
                       self.curr_pos.y, 
                       0, 
                       scale, 
                       scale,
                       self.width/2,
                       self.height/2 )
    self:debugDraw()
end

function PhysicsObject:onCollide()
    -- for shape, delta in pairs(self.hc:collisions(bullet.collider)) do
    --   self:destroy()
    -- end
end

function PhysicsObject:debugDraw()
    local x = self.curr_pos.x
    local y = self.curr_pos.y
    love.graphics.setColor(0,255,0)
    love.graphics.line( x, y, x+self.cur_speed.x*10, y+self.cur_speed.y*10)
    if self.deltaVector then
        love.graphics.setColor(255,0,0)
        love.graphics.line( x, y, x+self.deltaVector.x*10, y+self.deltaVector.y*10)
        love.graphics.setColor(0,0,255)
        love.graphics.line( x, y, x+self.deltaVector:perpendicular().x*10, y+self.deltaVector:perpendicular().y*10)
    end 
    love.graphics.setColor(255,255,255)
end

return PhysicsObject