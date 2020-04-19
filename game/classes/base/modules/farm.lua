Class = require "lib.hump.class"
Module = require "game.classes.base.module"

Farm = Class {
    __includes = Module,
    init = function(self, initialUnits, maxUnits, name)
        Module.init(self)
        self.units = initialUnits
        self.health = 0.5
        self.maxUnits = maxUnits
        self.wantedMaxUnits = maxUnits
        self.name = name
    end
}

function Farm:initOxygen(supplyUnit, sensitivity, consumption)
    self.oxygenSupply = supplyUnit
    self.oxygenSensitivity = sensitivity
    self.oxygenConsumption = consumption
end

function Farm:initStorage(inputStorage, outputStorage, consumption, production)
    self.inputStorage = inputStorage
    self.outputStorage = outputStorage
    self.foodConsumption = consumption
    self.foodProduction = production
end

function Farm:getName()
    return self.name
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
        if self.units == self.maxUnits then
            self:harvestToStorage(self.foodProduction)
        else
            self.units = self.units + 1
        end
        self.health = 0.1
    end
    if self.health < 0 and self.units > 0 then
        self.units = self.units - 1
    end
end

function Farm:harvestToStorage(foodUnits)
    self.outputStorage:add(foodUnits)
end

function Farm:update(dt)
    Module:update(dt)
    if self.oxygenConsumption then
        oxygenLevel = self.oxygenSupply:getLevel()
        self.oxygenSupply:add( -self.oxygenConsumption )
    end
    hpDelta = 0
    -- если кислорода меньше чувствительности, дельты здоровья меньше нуля
    -- если кислород - ок и входящей еды много - дельта больше нуля
    self:updateHealth(hpDelta)
end

return Farm