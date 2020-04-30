Class = require "lib.hump.class"

Drop = Class {
    __includes = PhysicsObject,
    init = function(self, x, y, count, type, index, hc)
        PhysicsObject.init(self, x, y, Images[type..'_drop'])
        self.count = count
        self.hc = hc
        self:registerCollider(self.hc)
        self.collider.type = 'drop'
        self.collider.resource = type
        self.collider.index = index
        self.collider.count = count
    end
}

function Drop:destroy()
  Loot[self.collider.index] = nil
  self.hc:remove(self.collider)
  self.collider = nil
end

function Drop:onCollide()
    for shape, delta in pairs(self.hc:collisions(self.collider)) do
      if self.collider.count <= 0 then
        self:destroy()
        return
      end
    end
end

return Drop