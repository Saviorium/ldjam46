Class = require "lib.hump.class"

Iron = Class {
    __includes = PhysicsObject,
    init = function(self, x, y, count, image)
        PhysicsObject.init(self, x, y, image)
        self.count = count
    end
}


return Iron