Class = require "lib.hump.class"
Asteroid = require "game/classes/asteroid"
Tile = require "game/classes/map/tile"

Map = Class {
    init = function(self, image_near, image_mid, image_far, player, hc)
    self.image_near = image_near
    self.image_mid  = image_mid
    self.image_far  = image_far
    self.player = player
    self.width  = self.image_near:getWidth()
    self.height = self.image_near:getHeight()
    self.hc = hc
    self.tiles      = {Tile(self.player.curr_pos.x-self.width/2, 
                            self.player.curr_pos.y-self.height/2, 
                            self.image_near,
                            0,
                            self.hc
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
    for index, tile in pairs(self.tiles) do
        tile:draw()
    end
end

function Map:update( dt )
    for index, tile in pairs(self.tiles) do
        self:checkBorder(index, tile)
        tile:move(self.player.cur_speed, dt)
    end
end

function Map:addTileToMap(x, y, tile)
    local bool = 1
    for _, object in pairs(self.tiles) do
        if object.curr_pos.x == x 
       and object.curr_pos.y == y 
       and object.speed_koef == tile.speed_koef then
            bool = 0
        end
    end
    if bool == 1 then
        table.insert(self.tiles, 
                     Tile(x, 
                          y, 
                          tile.image,
                          tile.speed_koef)
                    )
    end
end

function Map:checkBorders( index, tile)
    local x,y = self.curr_pos.x, self.curr_pos.y
    local width,height = 200 * scale + 10, 150 * scale + 10
    if Player.curr_pos.x + width + 50 < x 
   or Player.curr_pos.x - width - 50 > x + self.width 
   or Player.curr_pos.y + height+ 50 < y
   or Player.curr_pos.y - height- 50 > y + self.height 
  then
        table.remove(self.tiles, index)
    else
        if Player.curr_pos.x + width  > x + self.width then
            self:addTileToMap(x + self.width, y, tile )
        end
        if Player.curr_pos.x - width < x then
            self:addTileToMap(x - self.width, y, tile )
        end
        if Player.curr_pos.y + height > y + self.height then
            self:addTileToMap(x, y + self.height, tile )
        end
        if Player.curr_pos.y - height < y then
            self:addTileToMap(x, y - self.height, tile )
        end
    end
end

return Map