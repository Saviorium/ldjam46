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
        self.upgrade = {battery  = 1,
                        fire     = 1,
                        maneur   = 1,
                        recharge = 1,
                        space    = 1,
                        speed    = 1
                       } 
    end
}

function PlayerShip:checkFreeSpace()
    local freeSpace = 100 + self.upgrade.space*100
    for type, count in pairs(self.inventory) do
        if type ~= "energy" then
            freeSpace = freeSpace - count
        end
    end
    return freeSpace
end

return PlayerShip
