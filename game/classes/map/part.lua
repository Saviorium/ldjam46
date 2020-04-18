Class = require "lib.hump.class"
Asteroid = require "game/classes/asteroid"

Tile = Class {
    init = function(self, index, image_num, parts_width, parts_height)
        self.index = index
        self.image_num = image_num
        self.image = love.graphics.newImage('data/images/part_'..(image_num)..'.jpg')
        self.width = parts_width
        self.height =parts_height
    end
}

function Tile:draw( x, y)
    love.graphics.draw(self.image,
                       x + width*(index%4),
                       y + height*((index/3)-(index/3)%1), 
                       0, 
                       scale, 
                       scale)
end

function Tile:update( dt )
end


return Tile