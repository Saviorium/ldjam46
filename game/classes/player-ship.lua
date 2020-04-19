Class = require "lib.hump.class"

PlayerShip = Class {
    init = function(self)
        self.inventory = {
            iron = 0,
            ice = 0,
            oxygen = 100,
            energy = 100
        }
        self.upgrades = {}
    end
}

return PlayerShip
