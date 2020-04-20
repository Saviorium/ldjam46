Class = require "lib.hump.class"
StorageBox = require "game.classes.ui.storagebox"

StorageWithShipBox = Class {
    __includes = StorageBox,
    init = function(self, x, y, resource, storageUnit, shipStorage)
        StorageBox.init(self, x, y, resource, storageUnit)
        self.shipStorage = shipStorage
        self.buttons = {}
        table.insert(self.buttons, Button(x+79*scale, y+2*scale, "button-arrow-left", function() print("get from ship") end) )
        table.insert(self.buttons, Button(x+125*scale, y+2*scale, "button-arrow", function() print("add to ship") end) )
        self.shipScreen = Images['bigscreen']
    end
}

function StorageWithShipBox:registerButtons(eventManager)
    for id, object in pairs(self.buttons) do
        eventManager:registerObject(object)
    end
end

function StorageWithShipBox:draw()
    self:drawBox()
    for id, object in pairs(self.buttons) do
        object:draw()
    end
    love.graphics.draw(
        self.shipScreen,
        self.curr_pos.x+143*scale,
        self.curr_pos.y+9*scale,
        0,
        scale,
        scale
    )
end

return StorageWithShipBox