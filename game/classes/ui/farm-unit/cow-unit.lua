Class = require "lib.hump.class"
FarmUnit = require "game/classes/ui/farm-unit/farm-unit"

CowUnit = Class {
    __includes = FarmUnit,
    init = function(self, minX, maxX, minY, maxY)
        local image_screen = love.graphics.newImage("data/images/cam/cow/cow.png")
        image_screen:setFilter("nearest", "nearest")
        self.sprite = Peachy.new("data/images/cam/cow/cow.json", image_screen, "chew")
        FarmUnit.init(self, self.sprite, minX, maxX, maxY, minY)
    end
}

--[[function TreeUnit:animate(animFunction)
    animFunction()
end]]


function CowUnit:draw()
    self.sprite:draw(self.x, self.y, 0, scale, scale)
end

function CowUnit:update(dt)
    self.sprite:update(dt)
end

return CowUnit