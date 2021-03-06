Class = require "lib.hump.class"

Star = Class {
    init = function(self, player, hc)
        self.player = player
        self.curr_pos = Vector( 0, 
                                0 
                              )
        self:initPlace()
        self.speed_koef = math.random(0,8)/10
        self.image = Images['star_'..math.random(1,6)]
        self.width  = self.image:getWidth()*scale
        self.height = self.image:getHeight()*scale
        self.hc = hc
    end
}

function Star:draw()
    love.graphics.draw(self.image,
                       self.curr_pos.x,
                       self.curr_pos.y, 
                       0, 
                       scale, 
                       scale )
end

function Star:move()
    self.curr_pos = self.curr_pos + self.player.cur_speed*self.speed_koef
end

function Star:initPlace()
    local width, height = love.graphics.getWidth(), love.graphics.getHeight()
    local x,y = math.random(-width,width), 
                math.random(-height,height) 
    self.curr_pos.x = self.player.curr_pos.x + ((x<0) and -1 or 1)*(width/2  + 100 + math.abs(x))            
    self.curr_pos.y = self.player.curr_pos.y + ((y<0) and -1 or 1)*(height/2 + 100 + math.abs(y)) 
end

return Star