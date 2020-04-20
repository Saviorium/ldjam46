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
        self.parameters = {maxStorage = 1000}
    end
}

function PlayerShip:checkFreeSpace()
    local freeSpace = self.maxVolume
    for type, count in pairs(self.inventory) do
        if type ~= "energy" then
            freeSpace = freeSpace - count
        end
    end
    return freeSpace
end

return PlayerShip
