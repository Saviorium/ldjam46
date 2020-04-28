Class = require "lib.hump.class"

PlayerShip = Class {
    init = function(self)
        self.inventory = {
            iron = 0,
            ice = 0,
            oxygen = 10,
            energy = 100,
            foodVeg = 10,
            foodAnimal = 10
        }
        self.upgrade = {
            battery  = 1,
            fire     = 1,
            maneur   = 1,
            recharge = 1,
            space    = 1,
            speed    = 1
        }
        self.hp = 100
        self.oxygenConsume = 2
        self.foodConsume = 1
        self.death_o2_timer = 5
        self.death_food_timer = 30
        self.energyRecharge = 2 * math.pow(1.5, self.upgrade.recharge)
    end
}

function PlayerShip:getMaxVolume()
    return self.upgrade.space*100
end

function PlayerShip:getMaxEnergy()
    return self.upgrade.battery*100
end

function PlayerShip:getFood()
    return self.inventory.foodVeg + self.inventory.foodAnimal
end

function PlayerShip:getOxygen()
    return self.inventory.oxygen
end

function PlayerShip:getEnergy()
    return self.inventory.energy
end

function PlayerShip:getHP()
    return self.hp
end

function PlayerShip:getFreeSpace()
    local freeSpace = self:getMaxVolume()
    for type, count in pairs(self.inventory) do
        if type ~= "energy" then
            freeSpace = freeSpace - count
        end
    end
    return freeSpace
end

function PlayerShip:update(base, dt)
    if base then
        self:consumeOxygenFromMotherShip(dt)
        self:consumeFoodFromMotherShip(dt)
    else
        self:consumeOxygenFromShip(dt)
        self:consumeFoodFromShip(dt)
    end
    self:restoreEnergy(dt)

    if self.death_food_timer < 0 then
        StateManager.switch(states.end_game,3)
    elseif self.death_o2_timer < 0 then
        StateManager.switch(states.end_game,2)
    end
end

function PlayerShip:restoreEnergy(dt)
    if self.inventory["energy"] <= self:getMaxEnergy() then
        self.inventory["energy"] = self.inventory["energy"] + self.energyRecharge * dt
    end
end

function PlayerShip:consumeOxygenFromMotherShip(dt)
    if motherShip.storage.oxygen.value >= 0 then
        motherShip.storage.oxygen.value = motherShip.storage.oxygen.value - self.oxygenConsume * dt
        self.death_o2_timer = 5
    else
        self.death_o2_timer = self.death_o2_timer - dt
    end
end

function PlayerShip:consumeFoodFromMotherShip(dt)
    if motherShip.storage.foodVeg.value >= 0 and motherShip.storage.foodAnimal.value >= 0 then
        motherShip.storage.foodVeg.value = motherShip.storage.foodVeg.value - self.foodConsume/2 * dt
        motherShip.storage.foodAnimal.value = motherShip.storage.foodAnimal.value - self.foodConsume/2 * dt
        self.death_food_timer = 30
    elseif motherShip.storage.foodVeg.value >= 0 then
        motherShip.storage.foodVeg.value = motherShip.storage.foodVeg.value - self.foodConsume * dt
        self.death_food_timer = 30
    elseif motherShip.storage.foodAnimal.value >= 0 then
        motherShip.storage.foodAnimal.value = motherShip.storage.foodAnimal.value - self.foodConsume * dt
        self.death_food_timer = 30
    else
        self.death_food_timer = self.death_food_timer - dt
    end
end

function PlayerShip:consumeOxygenFromShip(dt)
    if self.inventory.oxygen >= 0 then
        self.inventory.oxygen = self.inventory.oxygen - self.oxygenConsume * dt
        self.death_o2_timer = 5
    else
        self.death_o2_timer = self.death_o2_timer - dt
    end
end

function PlayerShip:consumeFoodFromShip(dt)
    if self.inventory.foodVeg >= 0 and self.inventory.foodAnimal >= 0 then
        self.inventory.foodVeg = self.inventory.foodVeg - self.foodConsume/2 * dt
        self.inventory.foodAnimal = self.inventory.foodAnimal - self.foodConsume/2 * dt
        self.death_food_timer = 30
    elseif self.inventory.foodVeg >= 0 then
        self.inventory.foodVeg = self.inventory.foodVeg - self.foodConsume * dt
        self.death_food_timer = 30
    elseif self.inventory.foodAnimal >= 0 then
        self.inventory.foodAnimal = self.inventory.foodAnimal - self.foodConsume * dt
        self.death_food_timer = 30
    else
        self.death_food_timer = self.death_food_timer - dt
    end
end

function PlayerShip:getFreeSpaceText()
    local max = self:getMaxVolume()
    local taken = max - self:getFreeSpace()
    return string.format('%4.f', math.clamp(0, taken, 9999)) .. "/" .. string.format('%4.f', math.clamp(0, max, 9999))
end

return PlayerShip
