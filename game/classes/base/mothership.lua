Class = require "lib.hump.class"
StorageUnit = require "game.classes.base.storageunit"
Farm = require "game.classes.base.modules.farm"
Module = require "game.classes.base.module"

MotherShip = Class {
    init = function(self)
        self.storage = {
            energy     = StorageUnit(3000, 2000, "Energy"),
            iron       = StorageUnit(3000, 100, "Iron"),
            water      = StorageUnit(300000, 200000, "Water"),
            foodVeg    = StorageUnit(100, 50, "Vegetable food"),
            foodAnimal = StorageUnit(1000, 500, "Animal food"),
            oxygen     = StorageUnit(1000000, 1000000, "Oxygen"),
        }

        local vegFarm = Farm(5, 10, 0.005, "VegFarm")
        vegFarm:initOxygen(self.storage.oxygen, 0.2, -10)
        vegFarm:initStorage(self.storage.water, self.storage.foodVeg, 0.1, 15)

        local animalFarm = Farm(5, 10, 0.001, "AnimFarm")
        animalFarm:initOxygen(self.storage.oxygen, 0.5, 5)
        animalFarm:initStorage(self.storage.foodVeg, self.storage.foodAnimal, 0.01, 1)

        self.modules = {
            vegFarm = vegFarm,
            animalFarm = animalFarm
        }
    end
}

function MotherShip:addMaxVegFarm()
    value = self.modules.vegFarm.maxUnits + 1
    self.modules.vegFarm.maxUnits = value
    print(string.format("veg farm is now %d", value))
end

function MotherShip:addResources(type, value)
    return self.storage[type]:addAndGetExcess(value)
end

function MotherShip:changeWantedMaxUnitInFarm(farm, changeTo)
    farm:changeWantedMax(changeTo)
    print(string.format("button %d"..farm:getName(), changeTo))
end

function MotherShip:update(dt)
    for _, module in pairs(self.modules) do
        module:update(dt)
	end
end

function MotherShip:getStorage()
    return self.storage
end

function MotherShip:getModules()
    return self.modules
end

return MotherShip
