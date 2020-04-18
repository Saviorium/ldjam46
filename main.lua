StateManager = require "lib.hump.gamestate"
require 'conf'

states = {game = require "game.states.game"}

function love.load()
    love.window.setTitle("Ludum Dare 46 Game")
    StateManager.switch( states.game )
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

function love.keypressed(key)
    if StateManager.current().keypressed then
        StateManager.current():keypressed(key)
    end
end
