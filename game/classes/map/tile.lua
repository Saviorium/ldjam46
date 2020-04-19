Class = require "lib.hump.class"
Asteroid = require "game/classes/asteroid"

Tile = Class {
    init = function(self, x, y, image, speed_koef, hc)
        self.curr_pos = Vector( x, y )
        self.image = image
        self.width  = self.image:getWidth()*scale
        self.height = self.image:getHeight()*scale
        self.speed_koef = speed_koef
        self.hc = hc
        local bool = 1
        for _,asteroid in pairs(Asteroids) do
            if asteroid.curr_pos.x > x 
           and asteroid.curr_pos.x < x + self.width
           and asteroid.curr_pos.y > y 
           and asteroid.curr_pos.y < y + self.height then
                bool = 0
                return
            end
        end
        if bool == 1 then
            for i=1, 10 do
                bool = 1
                while bool == 1 do
                    temp = Asteroid(math.random(x,x+self.width ), --x
                                    math.random(y,y+self.height), --y
                                    math.random(0,360)/math.pi,   --angle
                                    love.graphics.newImage('data/images/asteroid/empty_0.png'),
                                    100, -- Hp
                                    100, -- drop
                                    'iron',  -- typeF
                                    self.hc
                                   )
                    if next(hc:collisions(temp.collider)) == nil then
                        table.insert(Asteroids,
                                     temp
                                    )
                        bool = 0
                    else
                      hc:remove(temp.collider)
                    end
                end
            end
        end
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

function Tile:move(moveVector, dt)
    self.curr_pos = self.curr_pos + moveVector*self.speed_koef*dt
end

return Tile