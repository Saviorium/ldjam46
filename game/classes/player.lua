Class = require "lib.hump.class"
PhysicsObject = require "game/classes/physical_object"

Player = Class {
    __includes = PhysicsObject,
    init = function(self, x, y, andgle, image, speed, maxVolume, HP)
    	PhysicsObject.init(self, x, y, image)
        self.maxVolume = maxVolume
        self.HP = HP
        self.angle = andgle
        self.turn_speed = 10
        self.speed = speed
    end
}

function Player:draw()
    love.graphics.draw(self.image,
                       self.curr_pos.x,
                       self.curr_pos.y, 
                       self.angle/math.pi+math.pi/2, 
                       scale, 
                       scale,
                       self.width/2,
                       self.height/2 )
    self:debugDraw()
end

function Player:update( dt )
    if love.keyboard.isDown( "up" ) then 
        self.cur_speed.x = self.cur_speed.x + self.speed*math.cos(self.angle/math.pi)*dt
        self.cur_speed.y = self.cur_speed.y + self.speed*math.sin(self.angle/math.pi)*dt
    end
    if love.keyboard.isDown( "down" ) then 
        self.cur_speed.x = self.cur_speed.x - self.speed/10*math.cos(self.angle/math.pi)*dt
        self.cur_speed.y = self.cur_speed.y - self.speed/10*math.sin(self.angle/math.pi)*dt
    end
    if love.keyboard.isDown( "left" ) then 
        self.angle = self.angle - 10*dt
    end
    if love.keyboard.isDown( "right" ) then
        self.angle = self.angle + 10*dt
    end
    --self:onCollide()
    self:move( self.cur_speed )
end

function Player:debugDraw()
    local x = self.curr_pos.x
    local y = self.curr_pos.y
    love.graphics.setColor(0,255,0)
    love.graphics.line( x, y, x+self.cur_speed.x*10, y+self.cur_speed.y*10)
    love.graphics.setColor(255,0,0)
    love.graphics.line( x, y, x+math.cos(self.angle/math.pi)*10, y+math.sin(self.angle/math.pi)*10)
    -- love.graphics.setColor(0,0,255)
    -- love.graphics.line( x, y, x+self.cur_speed.x*10, y+self.cur_speed.y*10)
    love.graphics.setColor(255,255,255)
end

return Player