Class = require "lib.hump.class"
Module = require "game.classes.base.module"

Farm = Class {
    __includes = Module,
    init = function(self, initialUnits, maxUnits, growthRate, name, image)
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
        self.cam_image = love.graphics.newImage('data/images/ui/farm-cam.png')
        self.cam_background = love.graphics.newImage('data/images/cam/wall_3.png')
        self.farm_image = image
    end
}

function Farm:drawFarm(x, y)
    love.graphics.draw(self.cam_background,
                        x+(5*scale),
                        y+(13*scale),
                        0,
                        scale,
                        scale)
    love.graphics.draw(self.cam_image,
                       x,
                       y, 
                       0, 
                       scale, 
                       scale)
    love.graphics.print(self.units,
                        x+29*scale,
                        y+4*scale
                       )
    love.graphics.print(self.wantedMaxUnits,
                        x+55*scale,
                        y+3*scale
                       )
    love.graphics.print(self.maxUnits,
                        x+103*scale,
                        y+4*scale
                       )
    love.graphics.print(self.name,
                        x+103*scale,
                        y+14*scale
                       )

end

function Farm:initResource(resource, rate, supplyUnit, sensitivity, consumption, production, base_affect, can_heal)
    self.resources[resource] = {}
    self.resources[resource]['rate']            = rate
    self.resources[resource]['storageUnit']     = supplyUnit
    self.resources[resource]['sensivity']       = sensitivity
    self.resources[resource]['consume_by_unit'] = consumption
    self.resources[resource]['produce_by_unit'] = production
    self.resources[resource]['base_affect']     = base_affect
    self.resources[resource]['can_heal']        = can_heal
end

function Farm:initOxygen(supplyUnit, sensitivity, consumption)
    self:initResource('oxygen', 1, supplyUnit, sensitivity, consumption, 0,20,0)
end

function Farm:initStorage( consumeResource, produceResource, inputStorage, outputStorage, consumptionPerUnit, productionPerUnit)

    self:initResource(consumeResource, 1, inputStorage , 0.8, consumptionPerUnit, 0 ,self.growthSpeed, 1)
    self:initResource(produceResource, 1, outputStorage, 1  , 0, productionPerUnit  ,0, 0)
    self.consumeResource = consumeResource
    self.produceResource = produceResource
end
function Farm:changeSupply(resource, change)
    self.resources[resource]['rate'] = self.resources[resource]['rate'] + change
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
end

function Farm:harvestToStorage(units)
    local unitsToHarvest = math.min(units, self.units)
    self.units = self.units - unitsToHarvest
    self.resources[self.produceResource]['storageUnit']:addAndGetExcess(unitsToHarvest * self.resources[self.produceResource]['produce_by_unit'])
end

function Farm:update(dt)
    Module:update(dt)
    local deltaHP = 0
    for index, resource in pairs(self.resources) do
        if resource['consume_by_unit'] ~= 0 then
            local cur_rate = 0
            local deficit = resource['storageUnit']:addAndGetExcess(- resource['rate'] * resource['consume_by_unit'] * self.units)
            if deficit >= 0 then
                cur_rate = resource['rate']
            end
            local cur_status = cur_rate - resource['sensivity']
            if not(resource['can_heal'] == 0 and cur_status > 0) then
                deltaHP = deltaHP + cur_status *  resource['base_affect'] * self.units
            end
        end
    end

    self.resources['oxygen']['rate'] = self.resources['oxygen']['storageUnit']:getLevel()

    self:updateHealth(deltaHP)
    local excessUnits = self.units - self:getWantedMaxUnit()
    if excessUnits > 0 then
        self:harvestToStorage(excessUnits)
    end
end

return Farm