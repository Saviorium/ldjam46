Class = require "lib.hump.class"

Drop = Class {
    __includes = PhysicsObject,
    init = function(self, x, y, count, image, type, hc)
        PhysicsObject.init(self, x, y, love.graphics.newImage('data/images/loot/ice.png'))
        self.count = count
        self.hc = hc
        self:registerCollider(self.hc)
        self.collider.type = type
    end
}

function Drop:destroy()
  for index, loot in pairs(Loot) do
    if loot.curr_pos.x == self.curr_pos.x and
       loot.curr_pos.y == self.curr_pos.y and
       loot.collider.type ==  self.collider.type then
      Loot[index] = nil
    end
  end
  self.hc:remove(self.collider)
end

function Drop:onCollide()
    for shape, delta in pairs(self.hc:collisions(self.collider)) do
      if shape.type == 'player' then 
      	if Player.maxVolume > (Player.iron + Player.ice + self.count) then 
          if self.collider.type == 'ice' then
            Player.ice  = Player.ice + self.count
          else
            Player.iron = Player.iron + self.count
          end
        	self:destroy()
        elseif Player.maxVolume > (Player.iron + Player.ice) then
        	local left_place = (Player.maxVolume - (Player.iron + Player.ice))
      		self.count = self.count - left_place
          if self.collider.type == 'ice' then
            Player.ice  = Player.ice + left_place
          else
            Player.iron = Player.iron + left_place
          end
      	end
      end
    end
end

return Drop