Class = require "lib.hump.class"
StorageUnit = require "game.classes.storageunit"
Farm = require "game.classes.base.modules.farm"
Module = require "game.classes.base.module"

MotherShip = Class {
    init = function(self)
        self.storage = {
            energy     = StorageUnit(3000, 2000),
            water      = StorageUnit(3000, 2000),
            foodVeg    = StorageUnit(100, 50),
            foodAnimal = StorageUnit(100, 50),
        }
        local oxygenSupply = OxygenSupply()

        local vegFarm = Farm(5, 10)
        vegFarm.initOxygen(oxygenSupply, 0.2, -10)
        vegFarm.initStorage(self.storage.water, self.storage.foodVeg)

        local animalFarm = Farm(5, 10)
        vegFarm.initOxygen(oxygenSupply, 0.2, 5)
        vegFarm.initStorage(self.storage.foodVeg, self.storage.foodAnimal)

        self.modules = {
            vegFarm,
            animalFarm,
            heatGenerator = Module(),
            oxygenSupply = oxygenSupply
        }
    end
}

function MotherShip:update(dt)
    for _, module in pairs(self.modules) do
		module:update(dt)
	end
end

return MotherShip
