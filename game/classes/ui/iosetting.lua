Class = require "lib.hump.class"
ButtonPlus = require "game.classes.ui.button-plus"

IOSetting = Class {
    __includes = IOBox,
    init = function(self, x, y, direction, resource)
        IOBox.init(self, x, y, direction, resource)
        self.buttons = {}
        table.insert(self.buttons, Button(x+58*scale, y+12*scale, "button-plus", function() motherShip:changeWantedMaxUnitInFarm(object, 1) end) )
        table.insert(self.buttons, Button(x+58*scale, y+20*scale, "button-minus", function() motherShip:changeWantedMaxUnitInFarm(object, -1) end) )
    end
}

function IOSetting:registerButtons(eventManager)
    for id, object in pairs(self.buttons) do
        eventManager:registerObject(object)
    end
end

function IOSetting:update(dt)
end

function IOSetting:draw()
    self:drawBox()
    for id, object in pairs(self.buttons) do
        object:draw()
    end
end

return IOSetting