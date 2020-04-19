EM = require "game.classes.event-manager"
ButtonPlus = require "game.classes.ui.button-plus"

local base = {}

function base:enter()
    self.objects = {}
    self.eventManager = EM()
    local button = ButtonPlus(20, 20)
    self.eventManager:registerObject( button )
    table.insert(self.objects, button)
end

function base:mousepressed(x, y)
    self.eventManager:mousepressed(x, y)
end

function base:mousereleased(x, y)
    self.eventManager:mousereleased(x, y)
end

function base:draw()
    for id, object in pairs(self.objects) do
        object:draw()
    end
end

function base:update( dt )
    self.eventManager:update(dt)
    for id, object in pairs(self.objects) do
        object:update( dt )
    end
end

return base