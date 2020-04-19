StateManager = require "lib.hump.gamestate"
require 'conf'

states = {
    game = require "game.states.game",
    base = require "game.states.base"
}

function love.load()
    love.window.setTitle("Ludum Dare 46 Game")
    love.graphics.setDefaultFilter("nearest", "nearest")
    StateManager.switch( states.base )
end

function love.draw()
    StateManager.draw()
end

function love.update( dt )
    StateManager.update(dt)
end

function love.mousepressed(x, y)
    if StateManager.current().mousepressed then
        StateManager.current():mousepressed( x, y )
    end	
end

function love.mousereleased(x, y)
    if StateManager.current().mousereleased then
        StateManager.current():mousereleased( x, y )
    end	
end

function love.keypressed(key)
    if StateManager.current().keypressed then
        StateManager.current():keypressed(key)
    end
end
