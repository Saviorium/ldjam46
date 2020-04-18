Class = require "lib.hump.class"

Asteroid = Class {
    init = function(self, x, y, partsCount)
        self.x = x
        self.y = y
        self.partsCount = partsCount
    end
}


return Asteroid