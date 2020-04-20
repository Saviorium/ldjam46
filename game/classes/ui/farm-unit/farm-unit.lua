Class = require "lib.hump.class"

FarmUnit = Class {
    init = function(self, sprite, minX, maxX, maxY, minY)
        self.sprite = sprite
        self.x = math.random(minX, maxX)
        self.y = math.random(minY, maxY)
    end
}

return FarmUnit
