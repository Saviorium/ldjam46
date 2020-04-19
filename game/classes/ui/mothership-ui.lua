Class = require "lib.hump.class"
ButtonPlus = require "game.classes.ui.button-plus"

MotherShipUI = Class {
    init = function(self, motherShip)
        self.motherShip = motherShip
        self.modules = {}
        self.buttons = {}
        self:initUI()
    end
}

function MotherShipUI:initUI()
    local button = ButtonPlus(20, 20, function() self.motherShip:addMaxVegFarm() end)
    table.insert(self.buttons, button)
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
end

return MotherShipUI