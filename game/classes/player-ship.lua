Class = require "lib.hump.class"

PlayerShip = Class {
    init = function(self)
        self.inventory = {
            iron = 0,
            ice = 0,
            oxygen = 100,
            energy = 100,
            food = 100
        }
        self.parameters = {addMaxStorage = 0,
                           addManeur = 0,
                           addSpeed = 0,
                           addMaxEnergy =0,
                           addRecharge = 0,
                           addROF = 0
                          }
    end
}

function PlayerShip:checkFreeSpace()
    local freeSpace = 100 + self.parameters.maxStorage
    for type, count in pairs(self.inventory) do
        if type ~= "energy" then
            freeSpace = freeSpace - count
        end
    end
    return freeSpace
end

return PlayerShip
