Class = require "lib.hump.class"
Asteroid = require "game/classes/cosmos/asteroid"

Tile = Class {
    init = function(self, x, y, image, hc)
        self.curr_pos = Vector( x, y )
        self.image = image
        self.width  = self.image:getWidth()*scale
        self.height = self.image:getHeight()*scale
        self.hc = hc
        self:checkAndCreateAsteroids()
    end
}

function Tile:draw()
    love.graphics.draw(self.image,
                       self.curr_pos.x,
                       self.curr_pos.y, 
                       0, 
                       scale, 
                       scale )
end

function Tile:checkAndCreateAsteroids()
    local bool = 1
    for _,asteroid in pairs(Asteroids) do
        if asteroid.curr_pos.x > self.curr_pos.x 
       and asteroid.curr_pos.x < self.curr_pos.x + self.width
       and asteroid.curr_pos.y > self.curr_pos.y 
       and asteroid.curr_pos.y < self.curr_pos.y + self.height then
            bool = 0
            return
        end
    end
    if bool == 1 then
        for i=1, 10 do
            bool = 1
            while bool == 1 do
                temp = Asteroid(math.random(self.curr_pos.x,self.curr_pos.x+self.width ), --x
                                math.random(self.curr_pos.y,self.curr_pos.y+self.height), --y
                                math.pi*(math.random(0,360)/180),   --angle
                                self.hc
                               )
                --if next(self.hc:collisions(temp.collider)) == nil then
                    table.insert(Asteroids,
                                 temp
                                )
                    bool = 0
                --else
                --  self.hc:remove(temp.collider)
                --end
            end
        end
    end
end

return Tile