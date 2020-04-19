Class = require "lib.hump.class"

Ice = Class {
    __includes = PhysicsObject,
    init = function(self, x, y, count, image)
        PhysicsObject.init(self, x, y, image)
        self.count = count
    end
}


return Ice