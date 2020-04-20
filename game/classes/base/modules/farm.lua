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
        self.resources = {}
    end
}

function Farm:initResource(resource, rate, supplyUnit, sensitivity, consumption, production, base_affect, affect)
    self.resources[resource] = {}
    self.resources[resource]['rate']            = rate
    self.resources[resource]['storageUnit']     = supplyUnit
    self.resources[resource]['sensivity']       = sensitivity
    self.resources[resource]['consume_by_unit'] = consumption
    self.resources[resource]['produce_by_unit'] = production
    self.resources[resource]['base_affect']     = base_affect
    self.resources[resource]['affect']          = affect
end

function Farm:initOxygen(supplyUnit, sensitivity, consumption)
    self:initResource('oxygen', 1, supplyUnit, sensitivity, consumption, 0,20, 'percent')
end

function Farm:initStorage( consumeResource, produceResource, inputStorage, outputStorage, consumptionPerUnit, productionPerUnit)

    self:initResource(consumeResource, 1, inputStorage , 0.8, consumptionPerUnit, 0 ,0,'by_unit')
    self:initResource(produceResource, 1, outputStorage, 1  , 0, productionPerUnit  ,0,'by_unit')
    self.consumeResource = consumeResource
    self.produceResource = produceResource
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
    self.resources[self.produceResource]['storageUnit']:addAndGetExcess(unitsToHarvest * self.resources[self.produceResource]['produce_by_unit'])
    print("killed "..unitsToHarvest.." in "..self.name)
end

function Farm:update(dt)
    Module:update(dt)
    local deltaHP_percent = 0
    local deltaHP_by_unit = 0
    for index, resource in pairs(self.resources) do
        if resource['consume_by_unit'] ~= 0 then
            local cur_rate = 0
            local deficit = resource['storageUnit']:addAndGetExcess(-resource['rate'] * resource['consume_by_unit'] * self.units)
            if deficit == 0 then
                cur_rate = resource['rate'] 
            end
            if cur_rate ~= resource['sensivity'] then
                if resource['affect'] == 'percent' then
                    deltaHP_percent = deltaHP_percent - resource['base_affect']*(resource['sensivity'] - resource['rate']) 
                    print(deltaHP_by_unit)
                elseif resource['affect'] == 'by_unit' then
                    deltaHP_by_unit = deltaHP_by_unit + (cur_rate - 1) * self.growthSpeed * self.units
                    print(deltaHP_by_unit)
                end
                if deltaHP_percent > 0 and deltaHP_by_unit > 0 then
                    deltaHP_by_unit = 0
                end 
            end
        end

    end

    hpDelta = deltaHP_percent + deltaHP_by_unit

    self:updateHealth(hpDelta)
    local excessUnits = self.units - self:getWantedMaxUnit()
    if excessUnits > 0 then
        self:harvestToStorage(excessUnits)
    end
end

return Farm