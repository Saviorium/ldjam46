Class = require "lib.hump.class"
IOBox = require "game.classes.ui.iobox"
IOSetting = require "game.classes.ui.iosetting"
StorageBox = require "game.classes.ui.storagebox"
StorageWithShipBox = require "game.classes.ui.storagewithshipbox"
UpgradesBox = require "game.classes.ui.upgradesbox"

MotherShipUI = Class {
    init = function(self, motherShip, playerShip)
        self.motherShip = motherShip
        self.playerShip = playerShip
        self.modules = {}
        self.buttons = {}
        self:initUI()

        local image_screen = love.graphics.newImage("data/images/ui/bgndscreen/screen.png")
        image_screen:setFilter("nearest", "nearest")
        sprite = Peachy.new("data/images/ui/bgndscreen/screen.json", image_screen, "loop")
        self.sprite = sprite
    end
}

function MotherShipUI:initUI()


    local x,y = 15*scale, 15*scale
    table.insert(self.buttons, Button(x+4*scale, y+2*scale, "button-plus", function() motherShip:changeWantedMaxUnitInFarm(motherShip.modules.animalFarm, 1) end) )
    table.insert(self.buttons, Button(x+15*scale, y+2*scale, "button-minus", function() motherShip:changeWantedMaxUnitInFarm(motherShip.modules.animalFarm, -1) end) )
    table.insert(self.buttons, Button(x+112*scale, y+3*scale, "button-plus", function() motherShip.modules.animalFarm:addMaxFarm() end))
    table.insert(self.buttons, Button(x+4*scale, y+(95+2)*scale, "button-plus", function() motherShip:changeWantedMaxUnitInFarm(motherShip.modules.vegFarm, 1) end) )
    table.insert(self.buttons, Button(x+15*scale, y+(95+2)*scale, "button-minus", function() motherShip:changeWantedMaxUnitInFarm(motherShip.modules.vegFarm, -1) end) )
    table.insert(self.buttons, Button(x+112*scale, y+(95+3)*scale, "button-plus", function() motherShip.modules.vegFarm:addMaxFarm() end)) 
    local x = 141*scale
    local storageX = 217*scale
    self.uiBoxes = {
        -- IOBoxes
        WaterBox_in    = IOSetting( x, 110 *scale, 'In', 'water', self.motherShip.modules['vegFarm']),
        OxygenBox_out  = IOBox( x, 141 *scale, 'Out', 'oxygen', self.motherShip.modules['vegFarm']),
        VegFoodBox_out = IOBox( x, 172 *scale, 'Out', 'foodVeg', self.motherShip.modules['vegFarm']),

        OxygenBox_in    = IOBox( x, 15 *scale, 'In', 'oxygen', self.motherShip.modules['animalFarm']),
        VegFoodBox_in   = IOSetting( x, 46 *scale, 'In', 'foodVeg', self.motherShip.modules['animalFarm']),
        MeatFoodBox_out = IOBox( x, 77 *scale, 'Out', 'foodAnimal', self.motherShip.modules['animalFarm']),

        -- Storage
        -- energyStorage     = StorageWithShipBox(storageX, 33*0*scale, 'energy',     self.motherShip.storage.energy),
        ironStorage       = StorageWithShipBox(storageX, 33*1*scale, 'iron',       self.motherShip.storage.iron, self.playerShip),
        waterStorage      = StorageWithShipBox(storageX, 33*2*scale, 'water',      self.motherShip.storage.water, self.playerShip),
        foodVegStorage    = StorageWithShipBox(storageX, 33*3*scale, 'foodVeg',    self.motherShip.storage.foodVeg, self.playerShip),
        foodAnimalStorage = StorageWithShipBox(storageX, 33*4*scale, 'foodAnimal', self.motherShip.storage.foodAnimal, self.playerShip),
        oxygenStorage     = StorageWithShipBox(storageX, 33*5*scale, 'oxygen',     self.motherShip.storage.oxygen ,self.playerShip),

        -- Upgrades
        upgradesBox = UpgradesBox(storageX, 33*6*scale, self.motherShip.storage.iron, self.playerShip)
    }
end

function MotherShipUI:registerButtons(eventManager)
    for id, object in pairs(self.buttons) do
        eventManager:registerObject(object)
    end
    for id, iobox in pairs(self.uiBoxes) do
        if iobox.registerButtons then
            iobox:registerButtons(eventManager)
        end
    end
end

function MotherShipUI:update(dt)
    self.sprite:update(dt)
end

function MotherShipUI:onTag(sprite)
    if (sprite.frameIndex == #sprite.tag.frames) and (sprite.tagName == "loop1" or sprite.tagName == "loop2") then
        sprite:setTag("loop")
    end
end

function MotherShipUI:draw()
    if self.sprite.tagName == "loop" then
        i = math.random(0,1000)
        if i == 1 then
            sprite:setTag("loop1")
        end
        if i == 2 then
            sprite:setTag("loop2")
        end
    end
    self.sprite:onLoop(MotherShipUI:onTag(self.sprite))
    self.sprite:draw(0, 0, 0, scale, scale)
    for id, object in pairs(self.modules) do
        object:draw()
    end
    local x,y = 15*scale, 15*scale
    motherShip.modules.animalFarm:drawFarm( x, y )
    motherShip.modules.vegFarm:drawFarm( x, y+95*scale )
    for id, object in pairs(self.uiBoxes) do
        object:draw()
    end
    for id, object in pairs(self.buttons) do
        object:draw()
    end
end

return MotherShipUI