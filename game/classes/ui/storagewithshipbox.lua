Class = require "lib.hump.class"
StorageBox = require "game.classes.ui.storagebox"

StorageWithShipBox = Class {
    __includes = StorageBox,
    init = function(self, x, y, resource, storageUnit, ship)
        StorageBox.init(self, x, y, resource, storageUnit)
        self.ship = ship
        self.buttons = {}
        if resource == 'foodVeg' or resource == 'foodAnimal' then
            self.ship_resource = 'food'
        elseif resource == 'water' then
            self.ship_resource = 'ice'
        else
            self.ship_resource = resource
        end
        table.insert(self.buttons, 
                     Button(x+79*scale, 
                            y+2*scale, 
                            "button-arrow-left", 
                            function() 
                                if self.ship.inventory[self.ship_resource] > 0 and storageUnit.value < storageUnit.max  then
                                    storageUnit.value = storageUnit.value + 10 
                                    self.ship.inventory[self.ship_resource] = self.ship.inventory[self.ship_resource] - 10  
                                end
                            end) 
                    )
        table.insert(self.buttons, 
                     Button(x+125*scale, 
                            y+2*scale,
                            "button-arrow", 
                            function() 
                                if self.ship.inventory[self.ship_resource] < self.ship:checkFreeSpace() and storageUnit.value >= 10 then
                                    storageUnit.value = storageUnit.value - 10 
                                    self.ship.inventory[self.ship_resource] = self.ship.inventory[self.ship_resource] + 10  
                                end
                            end) 
                    )
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
    love.graphics.draw( self.shipScreen,
                        self.curr_pos.x+143*scale,
                        self.curr_pos.y+9*scale, 
                        0, 
                        scale, 
                        scale
                      )
    love.graphics.print( self.ship.inventory[self.ship_resource],
                         self.curr_pos.x+145*scale,
                         self.curr_pos.y+11*scale, 
                         0, 
                         scale, 
                         scale
                       ) 
end

return StorageWithShipBox