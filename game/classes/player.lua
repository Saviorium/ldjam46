Class = require "lib.hump.class"

Player = Class {
    __includes = PhysicsObject,
    init = function(self, x, y, andgle, height, speed, width, maxVolume, HP)
    	PhysicsObject.init(self, x, y, height, width)
        self.maxVolume = maxVolume
        self.HP = HP
        self.angle = math.pi/2 + andgle*180
        self.turn_speed = 10
        self.speed = speed
    end
}

function Player.update( dt )
    if love.keyboard.isDown( "up" ) then 
        self.cur_speed.x = self.cur_speed.x + self.speed*math.cos(self.angle)*dt
        self.cur_speed.y = self.cur_speed.y + self.speed*math.sin(self.angle)*dt
    end
    if love.keyboard.isDown( "down" ) then 
        self.cur_speed.x = self.cur_speed.x + self.speed*math.cos(self.angle)*dt
        self.cur_speed.y = self.cur_speed.y + self.speed*math.sin(self.angle)*dt
    end
    if love.keyboard.isDown( "left" ) then 
        self.angle = self.angle - 10*dt
    end
    if love.keyboard.isDown( "right" ) then
        self.angle = self.angle + 10*dt
    end
end



return Player