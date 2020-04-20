FarmUnit = require "game/classes/ui/farm-unit/farm-unit"

TreeUnit = Class {
    __includes = FarmUnit,
    init = function(minX, maxX, maxY, minY)
        sprite = love.graphics.newImage("data/images/cam/buff.png")
        FarmUnit.init(self, sprite, minX, maxX, maxY, minY)
    end
}

--[[function TreeUnit:animate(animFunction)
    animFunction()
end]]


function TreeUnit:draw()
    FarmUnit.draw(self)
end
