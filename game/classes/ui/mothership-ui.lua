Class = require "lib.hump.class"
ButtonPlus = require "game.classes.ui.button-plus"
IOBox = require "game.classes.ui.iobox"
IOSetting = require "game.classes.ui.iosetting"

MotherShipUI = Class {
    init = function(self, motherShip)
        self.motherShip = motherShip
        self.modules = {}
        self.buttons = {}
        self:initUI()
    end
}

function MotherShipUI:initUI()
    local button = Button(160, 25, "button-plus", function() self.motherShip:addMaxVegFarm() end)
    table.insert(self.buttons, button)

    local i = 0
    for id, object in pairs(motherShip:getModules()) do
        i = i+1
        table.insert(self.buttons, Button(10*scale, (20 + 20*(i))*scale, "button-plus", function() motherShip:changeWantedMaxUnitInFarm(object, 1) end) )
        table.insert(self.buttons, Button(25*scale, (20 + 20*(i))*scale, "button-minus", function() motherShip:changeWantedMaxUnitInFarm(object, -1) end) )
    end
    local x = 143*scale
    self.IOBoxes = {
    OxygenBox_in    = IOBox( x, 30*scale, 'In', 'oxygen'),
    VegFoodBox_in   = IOSetting( x, 61*scale, 'In', 'foodVeg'),
    MeatFoodBox_out = IOBox( x, 92*scale, 'Out', 'foodAnimal'),

    WaterBox_in    = IOSetting( x, 132*scale, 'In', 'water'),
    OxygenBox_out  = IOBox( x, 163*scale, 'Out', 'oxygen'),
    VegFoodBox_out = IOBox( x, 194*scale, 'Out', 'foodVeg')
    }

end

function MotherShipUI:registerButtons(eventManager)
    for id, object in pairs(self.buttons) do
        eventManager:registerObject(object)
    end
end

function MotherShipUI:update(dt)
end

function MotherShipUI:draw()
    for id, object in pairs(self.modules) do
        object:draw()
    end
    for id, object in pairs(self.buttons) do
        object:draw()
    end
    local i = 0
    for id, object in pairs(motherShip:getStorage()) do
        i = i+1
        love.graphics.print(object:getName(), 10, 20*i)
        love.graphics.print(object:getValue(), 80, 20*i)
        love.graphics.print(object:getMax(), 150, 20*i)
    end
    i = 0
    for id, object in pairs(motherShip:getModules()) do
        i = i+1
        love.graphics.print(object:getName()..": "..object:getCurrentUnits().."/"..object:getWantedMaxUnit().."(max: "..object:getMaxUnit()..")", 45*scale, (25 + 20*(i))*scale)
    end
    for id, object in pairs(self.IOBoxes) do
        object:draw()
    end
end

return MotherShipUI