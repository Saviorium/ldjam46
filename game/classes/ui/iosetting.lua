Class = require "lib.hump.class"
Button = require "game.classes.ui.button"

IOSetting = Class {
    __includes = IOBox,
    init = function(self, x, y, direction, resource)
        IOBox.init(self, x, y, direction, resource)
        self.buttons = {}
        table.insert(self.buttons, Button(x+57*scale, y+14*scale, "button-plus", function() motherShip:changeWantedMaxUnitInFarm(object, 1) end) )
        table.insert(self.buttons, Button(x+57*scale, y+21*scale, "button-minus", function() motherShip:changeWantedMaxUnitInFarm(object, -1) end) )
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