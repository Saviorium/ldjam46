Class = require "lib.hump.class"
StorageBox = require "game.classes.ui.storagebox"
tracks          = require "data/tracks"

StorageWithShipBox = Class {
    __includes = StorageBox,
    init = function(self, x, y, resource, storageUnit, ship)
        StorageBox.init(self, x, y, resource, storageUnit)

        self.ship = ship
        self.buttons = {}
        if resource == 'water' then
            self.ship_resource = 'ice'
        else
            self.ship_resource = resource
        end
        table.insert(self.buttons, 
                     Button(x+79*scale, 
                            y+2*scale, 
                            "button-arrow-left", 
                            function()
                                if self.ship.inventory[self.ship_resource] - 10 >= 0 and storageUnit.value < storageUnit.max  then
                                    storageUnit.value = storageUnit.value + 10
                                    self.ship.inventory[self.ship_resource] = self.ship.inventory[self.ship_resource] - 10
                                    tracks.play_sound( tracks.list_of_sounds.button )
                                elseif self.ship.inventory[self.ship_resource] > 0 and math.modf(storageUnit.value)+1 < storageUnit.max  then
                                    local freeSpace = storageUnit.max - math.modf(storageUnit.value)+1
                                    if freeSpace > self.ship.inventory[self.ship_resource] then
                                        storageUnit.value = storageUnit.value + self.ship.inventory[self.ship_resource]
                                        self.ship.inventory[self.ship_resource] = 0
                                    else
                                        storageUnit.value = storageUnit.max-1 + storageUnit.value%1
                                        self.ship.inventory[self.ship_resource] = self.ship.inventory[self.ship_resource] - freeSpace
                                    end
                                    tracks.play_sound( tracks.list_of_sounds.button )
                                else
                                    tracks.play_sound( tracks.list_of_sounds.error_button )
                                end
                            end) 
                    )
        table.insert(self.buttons, 
                     Button(x+125*scale, 
                            y+2*scale,
                            "button-arrow", 
                            function()
                                if  self.ship:getFreeSpace() >= 10 and storageUnit.value >= 10 then
                                    storageUnit.value = storageUnit.value - 10
                                    self.ship.inventory[self.ship_resource] = self.ship.inventory[self.ship_resource] + 10
                                    tracks.play_sound( tracks.list_of_sounds.button )
                                elseif math.modf(self.ship:getFreeSpace()) > 0 and storageUnit.value >= 1 then
                                    if math.modf(self.ship:getFreeSpace()) > storageUnit.value then
                                        self.ship.inventory[self.ship_resource] = self.ship.inventory[self.ship_resource] + math.modf(storageUnit.value)
                                        storageUnit.value = storageUnit.value%1
                                    else
                                        storageUnit.value = storageUnit.value - self.ship:getFreeSpace()
                                        self.ship.inventory[self.ship_resource] = self.ship.inventory[self.ship_resource] + self.ship:getFreeSpace()
                                    end
                                    tracks.play_sound( tracks.list_of_sounds.button )
                                else
                                    tracks.play_sound( tracks.list_of_sounds.error_button )
                                end
                            end) 
                    )
        self.shipScreen = Images['bigscreen']
    end
}

function StorageWithShipBox:registerButtons(eventManager)
    for _, object in pairs(self.buttons) do
        eventManager:registerObject(object)
    end
end

function StorageWithShipBox:draw()
    self:drawBox()
    for _, object in pairs(self.buttons) do
        object:draw()
    end
    love.graphics.draw( self.shipScreen,
                        self.curr_pos.x+143*scale,
                        self.curr_pos.y+9*scale, 
                        0, 
                        scale, 
                        scale
                      )

    love.graphics.setFont(fonts.numbers)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(
        string.format('%4.f', math.min(math.max(self.ship.inventory[self.ship_resource], 0), 9999)),
        self.curr_pos.x+145*scale,
        self.curr_pos.y+12*scale, 
        0, 
        scale, 
        scale
    ) 
end

return StorageWithShipBox