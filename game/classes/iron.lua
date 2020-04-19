Class = require "lib.hump.class"

Iron = Class {
    __includes = PhysicsObject,
    init = function(self, x, y, count)
        PhysicsObject.init(self, x, y, love.graphics.newImage('data/images/loot/iron.png'))
        self.count = count
    end
}


return Iron