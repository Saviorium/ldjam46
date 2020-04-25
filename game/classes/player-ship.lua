Class = require "lib.hump.class"

PlayerShip = Class {
    init = function(self)
        self.inventory = {
            iron = 0,
            ice = 0,
            oxygen = 10,
            energy = 100,
            foodVeg = 10,
            foodAnimal = 10
        }
        self.upgrade = {
            battery  = 1,
            fire     = 1,
            maneur   = 1,
            recharge = 1,
            space    = 1,
            speed    = 1
        }
        self.hp = 100
    end
}

function PlayerShip:getMaxVolume()
    return self.upgrade.space*100
end

function PlayerShip:getMaxEnergy()
    return self.upgrade.battery*100
end

function PlayerShip:getFreeSpace()
    local freeSpace = self:getMaxVolume()
    for type, count in pairs(self.inventory) do
        if type ~= "energy" then
            freeSpace = freeSpace - count
        end
    end
    return freeSpace
end

function PlayerShip:getFreeSpaceText()
    local max = self:getMaxVolume()
    local taken = max - self:getFreeSpace()
    return string.format('%4.f', math.min(math.max(taken, 0),9999)) .. "/" .. string.format('%4.f', math.min(math.max(max, 0),9999))
end

return PlayerShip
