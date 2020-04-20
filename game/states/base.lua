EM = require "game.classes.event-manager"
MotherShipUI = require "game.classes.ui.mothership-ui"
MotherShip = require "game.classes.base.mothership"

local base = {}

function base:enter()
    if not motherShip then
        motherShip = MotherShip()
    end
    self.objects = {
        motherShipUI = MotherShipUI(motherShip),
        motherShip = motherShip
    }
    self.eventManager = EM()
    self.objects.motherShipUI:registerButtons(self.eventManager)
end

function base:mousepressed(x, y)
    self.eventManager:mousepressed(x, y)
end

function base:mousereleased(x, y)
    self.eventManager:mousereleased(x, y)
end

function base:keypressed( key )
    if key == "space" then
        StateManager.switch( states.cosmos )
    end
end

function base:draw()
    for id, object in pairs(self.objects) do
        if object.draw then
            object:draw()
        end
    end
end

function base:update( dt )
    self.eventManager:update(dt)
    for id, object in pairs(self.objects) do
        object:update( dt )
    end
end

return base