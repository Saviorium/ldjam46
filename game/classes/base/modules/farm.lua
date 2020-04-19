Class = require "lib.hump.class"
Module = require "game.classes.base.module"

Farm = Class {
    __includes = Module,
    init = function(self, initialUnits, maxUnits, growthRate, name)
        Module.init(self)
        self.units = initialUnits
        self.health = 0.5
        self.maxUnits = maxUnits
        self.wantedMaxUnits = maxUnits
        self.name = name
        self.foodSupplyRate = 1.1
        self.baseOxygenDamage = 0.01
        self.growthSpeed = growthRate
    end
}

function Farm:initOxygen(supplyUnit, sensitivity, consumption)
    self.oxygenSupply = supplyUnit
    self.oxygenSensitivity = sensitivity
    self.oxygenConsumption = consumption
end

function Farm:initStorage(inputStorage, outputStorage, consumptionPerUnit, production)
    self.inputStorage = inputStorage
    self.outputStorage = outputStorage
    self.foodConsumption = consumptionPerUnit
    self.foodProduction = production
end

function Farm:setFoodSupply(rate)
    self.foodSupplyRate = rate
end

function Farm:getName()
    return self.name
end

function Farm:getCurrentUnits()
    return self.units
end

function Farm:getMaxUnit()
    return self.maxUnits
end

function Farm:getWantedMaxUnit()
    return self.wantedMaxUnits
end

function Farm:changeWantedMax(changeTo)
    print(string.format(self:getName().." + %d", changeTo))
    if (self.wantedMaxUnits + changeTo <= self.maxUnits) and (self.wantedMaxUnits + changeTo >= 0) then
        print(string.format(self:getName().." = %d", changeTo))
        self.wantedMaxUnits = self.wantedMaxUnits + changeTo
    end
end

function Farm:updateHealth(delta)
    if self.units > 0 then
        self.health = self.health + delta
    end

    if self.health > 1 then
        self:growNewUnits(1)
        self.health = 0.1
    end
    if self.health < 0 and self.units > 0 then
        self.units = self.units - 1
        self.health = 0.9
    end
end

function Farm:growNewUnits(units)
    self.units = self.units + units
    print("new "..units.." in "..self.name)
end

function Farm:harvestToStorage(units)
    local unitsToHarvest = math.min(units, self.units)
    self.units = self.units - unitsToHarvest
    self.outputStorage:add(unitsToHarvest * self.foodProduction)
    print("killed "..unitsToHarvest.." in "..self.name)
end

function Farm:update(dt)
    Module:update(dt)
    local oxygenDamage = 0
    if self.oxygenConsumption then
        local oxygenLevel = self.oxygenSupply:getLevel()
        self.oxygenSupply:add( -(self.oxygenConsumption * self.units) )
        -- oxyLevel = 0% => 100% baseOxygenDamage
        -- oxyLevel = oxygenSensitivity% => 0% baseOxygenDamage
        if oxygenLevel < self.oxygenSensitivity then
            oxygenDamage = self.baseOxygenDamage * (self.oxygenSensitivity - oxygenLevel) 
        end
    end
    local foodSatisfaction = 0
    if self.foodConsumption then
        local foodToConsume = self.foodSupplyRate * self.foodConsumption * self.units
        local foodDeficit = self.inputStorage:addAndGetExcess(-foodToConsume)
        if foodDeficit == 0 then
            foodSatisfaction = self.foodSupplyRate
        end
    end
    local hpDelta = (foodSatisfaction - 1) * self.growthSpeed * self.units
    if self.foodSupplyRate > 1 and oxygenDamage > 0 then
        hpDelta = 0
    end
    hpDelta = hpDelta + oxygenDamage

    self:updateHealth(hpDelta)
    local excessUnits = self.units - self:getWantedMaxUnit()
    if excessUnits > 0 then
        self:harvestToStorage(excessUnits)
    end
end

return Farm