Class = require "lib.hump.class"
Tile = require "game/classes/cosmos/map/tile"
Star = require "game/classes/cosmos/map/star"

Map = Class {
    init = function(self, image, player, baseShip, hc)
    self.image      = image
    self.player     = player
    self.baseShip   = baseShip
    self.width      = self.image:getWidth()
    self.height     = self.image:getHeight()
    self.hc         = hc
    self.tiles      = {Tile(self.player.curr_pos.x-self.width/2, 
                            self.player.curr_pos.y-self.height/2, 
                            self.image,
                            self.hc
                           )
                      }
    self.distant_stars = {}
    self:starsInit()
    end
}

function Map:draw()
    for index, star in pairs(self.distant_stars) do
        star:draw()
    end
    for index, tile in pairs(self.tiles) do
        tile:draw()
    end
end

function Map:update( dt )
    for index, tile in pairs(self.tiles) do
        self:checkBorders(index, tile)
    end
    for index, star in pairs(self.distant_stars) do
        if Vector(star.curr_pos.x - self.player.curr_pos.x,
                  star.curr_pos.y - self.player.curr_pos.y
                 ):len() > 1000*scale then
            self.distant_stars[index] = Star(self.player, self.hc)
        end
        star:move()
    end
end

function Map:addTileToMap(x, y, tile)
    local bool = 1
    for _, object in pairs(self.tiles) do
        if object.curr_pos.x == x 
       and object.curr_pos.y == y then
            bool = 0
        end
    end
    if bool == 1 then
        table.insert(self.tiles, 
                     Tile(x, 
                          y, 
                          tile.image,
                          self.hc)
                    )
    end
end
function Map:starsInit()
    for i=1, 100 do
        table.insert(self.distant_stars,
                     Star(self.player, self.hc)
                    )
    end
end

function Map:checkBorders( index, tile)
    local x,y = tile.curr_pos.x, tile.curr_pos.y
    local width,height = love.graphics.getWidth()/2 + 10, love.graphics.getHeight()/2 + 10
    if self.player.curr_pos.x + width + 50 < x 
    or self.player.curr_pos.x - width - 50 > x + tile.width 
    or self.player.curr_pos.y + height+ 50 < y
    or self.player.curr_pos.y - height- 50 > y + tile.height 
    then
        table.remove(self.tiles, index)
    else
        if self.player.curr_pos.x + width  > x + tile.width then
            self:addTileToMap(x + tile.width, y, tile )
        end
        if self.player.curr_pos.x - width < x then
            self:addTileToMap(x - tile.width, y, tile )
        end
        if self.player.curr_pos.y + height > y + tile.height then
            self:addTileToMap(x, y + tile.height, tile )
        end
        if self.player.curr_pos.y - height < y then
            self:addTileToMap(x, y - tile.height, tile )
        end
    end
end

return Map