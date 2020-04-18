Class = require "lib.hump.class"
Asteroid = require "game/classes/asteroid"
Tile = require "game/classes/map/tile"

Map = Class {
    init = function(self, image_near, image_mid, image_far)
    self.image_near = image_near
    self.image_mid  = image_mid
    self.image_far  = image_far

    self.width  = self.image_near:getWidth()
    self.height = self.image_near:getHeight()

    self.tiles      = {Tile(Player.curr_pos.x-self.width/2, 
                            Player.curr_pos.y-self.height/2, 
                            self.image_near,
                            0
                           )
                     -- , Tile(Player.curr_pos.x-self.width/2, 
                     --        Player.curr_pos.y-self.height/2,  
                     --        self.image_mid,
                     --        0.5
                     --       )
                     -- , Tile(Player.curr_pos.x-self.width/2, 
                     --        Player.curr_pos.y-self.height/2, 
                     --        self.image_far,
                     --        0.2
                     --       )
                      }
    end
}

function Map:draw()
    for _, tile in pairs(self.tiles) do
        tile:draw()
    end
end

function Map:update( dt )
    for index, tile in pairs(self.tiles) do
        tile:checkBorder(index, self.tiles)
        tile:move(Player.cur_speed, dt)
    end
end

return Map