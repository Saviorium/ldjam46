Class = require "lib.hump.class"
IOBox = require "game.classes.ui.iobox"
IOSetting = require "game.classes.ui.iosetting"
StorageBox = require "game.classes.ui.storagebox"
StorageWithShipBox = require "game.classes.ui.storagewithshipbox"
UpgradesBox = require "game.classes.ui.upgradesbox"
tracks          = require "data/tracks"

MotherShipUI = Class {
    init = function(self, motherShip, playerShip)
        self.motherShip = motherShip
        self.playerShip = playerShip
        self.modules = {}
        self.buttons = {}
        self:initUI()
        self.spaceHelp = Images['helpSpaceToSpace']

        local image_screen = love.graphics.newImage("data/images/ui/bgndscreen/screen.png")
        image_screen:setFilter("nearest", "nearest")
        sprite = Peachy.new("data/images/ui/bgndscreen/screen.json", image_screen, "loop")
        self.sprite = sprite
    end
}

function MotherShipUI:initUI()

    local x,y = 15*scale, 15*scale
    table.insert(self.buttons, Button(x+47*scale, y+2*scale, "button-plus-big", function() motherShip:changeWantedMaxUnitInFarm(motherShip.modules.animalFarm, 1) end) )
    table.insert(self.buttons, Button(x+58*scale, y+2*scale, "button-minus-big", function() motherShip:changeWantedMaxUnitInFarm(motherShip.modules.animalFarm, -1) end) )
    table.insert(self.buttons, Button(x+111*scale, y+2*scale, "button-plus-big", function() motherShip.modules.animalFarm:addMaxFarm() end))
    table.insert(self.buttons, Button(x+47*scale, y+(101+2)*scale, "button-plus-big", function() motherShip:changeWantedMaxUnitInFarm(motherShip.modules.vegFarm, 1) end) )
    table.insert(self.buttons, Button(x+58*scale, y+(101+2)*scale, "button-minus-big", function() motherShip:changeWantedMaxUnitInFarm(motherShip.modules.vegFarm, -1) end) )
    table.insert(self.buttons, Button(x+111*scale, y+(101+2)*scale, "button-plus-big", function() motherShip.modules.vegFarm:addMaxFarm() end))

    table.insert(self.buttons, Button(14*scale, 216*scale, "button-warp", function() self:winButtonEvent() end))
    local x = 141*scale
    local storageX = 217*scale
    self.uiBoxes = {
        -- IOBoxes
        OxygenBox_in    = IOBox( x, 15 *scale, 'In', 'oxygen', self.motherShip.modules['animalFarm']),
        VegFoodBox_in   = IOSetting( x, 48 *scale, 'In', 'foodVeg', self.motherShip.modules['animalFarm']),
        MeatFoodBox_out = IOBox( x, 81 *scale, 'Out', 'foodAnimal', self.motherShip.modules['animalFarm']),

        WaterBox_in    = IOSetting( x, 116 *scale, 'In', 'water', self.motherShip.modules['vegFarm']),
        OxygenBox_out  = IOBox( x, 149 *scale, 'Out', 'oxygen', self.motherShip.modules['vegFarm']),
        VegFoodBox_out = IOBox( x, 182 *scale, 'Out', 'foodVeg', self.motherShip.modules['vegFarm']),

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

function MotherShipUI:winButtonEvent()
    if self.motherShip.storage.iron:getValue() >= 10000 then
        StateManager.switch(states.end_game,4)
    else
        tracks.play_sound( tracks.list_of_sounds.error_button )
    end
end

function MotherShipUI:update(dt)
    self.sprite:update(dt)
    for _, obj in pairs(self.uiBoxes) do
        if obj.update then obj:update(dt) end
    end
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
            self.sprite:setTag("loop1")
            tracks.play_sound( tracks.list_of_sounds.static_1 )
        end
        if i == 2 then
            self.sprite:setTag("loop2")
            tracks.play_sound( tracks.list_of_sounds.static_2 )
        end
    end
    self.sprite:onLoop(MotherShipUI:onTag(self.sprite))
    self.sprite:draw(0, 0, 0, scale, scale)
    for id, object in pairs(self.modules) do
        object:draw()
    end

    love.graphics.draw(
        self.spaceHelp,
        127*scale,
        264*scale, 
        0, 
        scale, 
        scale)
 
    motherShip.modules.animalFarm:drawFarm()
    motherShip.modules.vegFarm:drawFarm()

    for id, object in pairs(self.uiBoxes) do
        object:draw()
    end
    for id, object in pairs(self.buttons) do
        object:draw()
    end
end

return MotherShipUI