Class = require "lib.hump.class"
StorageUnit = require "game.classes.base.storageunit"
Farm = require "game.classes.base.modules.farm"
Module = require "game.classes.base.module"
TreeUnit = require "game.classes.ui.farm-unit.tree-unit"

MotherShip = Class {
    init = function(self)
        self.storage = {
            energy     = StorageUnit(3000, 2000, "Energy"),
            iron       = StorageUnit(3000, 0, "Iron"),
            water      = StorageUnit(5000, 1500, "Water"),
            foodVeg    = StorageUnit(1000, 50, "Vegetable food"),
            foodAnimal = StorageUnit(1000, 50, "Animal food"),
            oxygen     = StorageUnit(2500, 1500, "Oxygen"),
        }
        local vegFarm = Farm(8, 7, 0.15, "VegFarm", 15*scale, 116*scale,5 )
        vegFarm:initOxygen(self.storage.oxygen, 0.2, -2)
        vegFarm:initStorage('water', -- consumeResource
                            'foodVeg', -- produceResource
                            self.storage.water, --inputStorage
                            self.storage.foodVeg, --outputStorage
                            1, --consumptionPerUnit
                            3)--productionPerUnit
        vegFarm:initUnits(vegFarm.units)

        local animalFarm = Farm(1, 5, 0.1, "AnimFarm", 15*scale, 15*scale,2)
        animalFarm:initOxygen(self.storage.oxygen, 0.5, 3.5)
        animalFarm:initStorage('foodVeg', -- consumeResource
                                'foodAnimal', -- produceResource
                                self.storage.foodVeg, --inputStorage
                                self.storage.foodAnimal, --outputStorage
                                0.15, --consumptionPerUnit
                                10     --productionPerUnit)
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
end

function MotherShip:addResources(type, value)
    return self.storage[type]:addAndGetExcess(value)
end

function MotherShip:changeWantedMaxUnitInFarm(farm, changeTo)
    farm:changeWantedMax(changeTo)
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
