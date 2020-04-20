Class = require "lib.hump.class"
StorageUnit = require "game.classes.base.storageunit"
Farm = require "game.classes.base.modules.farm"
Module = require "game.classes.base.module"
TreeUnit = require "game.classes.ui.farm-unit.tree-unit"

MotherShip = Class {
    init = function(self)
        self.storage = {
            energy     = StorageUnit(3000, 2000, "Energy"),
            iron       = StorageUnit(3000, 1000, "Iron"),
            water      = StorageUnit(10000, 5000, "Water"),
            foodVeg    = StorageUnit(1000, 50, "Vegetable food"),
            foodAnimal = StorageUnit(1000, 500, "Animal food"),
            oxygen     = StorageUnit(10000, 5000, "Oxygen"),
        }
        local vegFarm = Farm(5, 10, 0.005, "VegFarm", 15*scale, 116*scale )
        vegFarm:initOxygen(self.storage.oxygen, 0.2, -5)
        vegFarm:initStorage('water', -- consumeResource
                'foodVeg', -- produceResource
                self.storage.water, --inputStorage
                self.storage.foodVeg, --outputStorage
                0.05, --consumptionPerUnit
                15)--productionPerUnit
        vegFarm:initUnits(vegFarm.units)

        local animalFarm = Farm(5, 10, 0.001, "AnimFarm", 15*scale, 15*scale)
        animalFarm:initOxygen(self.storage.oxygen, 0.5, 1)
        animalFarm:initStorage('foodVeg', -- consumeResource
                'foodAnimal', -- produceResource
                self.storage.foodVeg, --inputStorage
                self.storage.foodAnimal, --outputStorage
                0.5, --consumptionPerUnit
                100     --productionPerUnit)
        )
        animalFarm:initUnits(animalFarm.units)

        self.modules = {
            animalFarm = animalFarm,
            vegFarm = vegFarm,
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
