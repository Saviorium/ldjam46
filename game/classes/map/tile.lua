Class = require "lib.hump.class"
Asteroid = require "game/classes/asteroid"

Tile = Class {
    init = function(self, x, y, image, speed_koef)
        self.curr_pos = Vector( x, y )
        self.image = image
        self.width  = self.image:getWidth()*scale
        self.height = self.image:getHeight()*scale
        self.speed_koef = speed_koef
        local bool = 1
        for _,asteroid in pairs(Astreroids) do
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
                                    'iron'  -- type
                                   )
                    temp:registerCollider(HC)
                    if next(HC:collisions(temp.collider)) == nil then
                        table.insert(Astreroids,
                                     temp
                                    )
                        bool = 0
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

function Tile:addTileToMap(x, y, tiles)
    local bool = 1
    for _, object in pairs(tiles) do
        if object.curr_pos.x == x 
       and object.curr_pos.y == y 
       and object.speed_koef == self.speed_koef then
            bool = 0
        end
    end
    if bool == 1 then
        table.insert(tiles, 
             Tile(x, 
                  y, 
                  self.image,
                  self.speed_koef)
            )
    end
end

function Tile:checkBorder(index, tiles)
    local x,y = self.curr_pos.x, self.curr_pos.y
    local width,height = 200 * scale + 10, 150 * scale + 10
    if Player.curr_pos.x + width + 50 < x 
   or Player.curr_pos.x - width - 50 > x + self.width 
   or Player.curr_pos.y + height+ 50 < y
   or Player.curr_pos.y - height- 50 > y + self.height 
  then
        print(index)
        table.remove(tiles, index)
    else
        if Player.curr_pos.x + width  > x + self.width then
            self:addTileToMap(x + self.width, y, tiles)
        end
        if Player.curr_pos.x - width < x then
            self:addTileToMap(x - self.width, y, tiles)
        end
        if Player.curr_pos.y + height > y + self.height then
            self:addTileToMap(x, y + self.height, tiles)
        end
        if Player.curr_pos.y - height < y then
            self:addTileToMap(x, y - self.height, tiles)
        end
    end
    
end

return Tile