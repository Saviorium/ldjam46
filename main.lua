StateManager = require "lib.hump.gamestate"
require "conf"
require "game.utils"

serpent = require "lib.debug.serpent"
states = {
    start_game = require "game.states.start_game",
    game = require "game.states.game",
    end_game = require "game.states.end_game",
    base = require "game.states.base",
    cosmos = require "game.states.cosmos"
}

strings = {''}

function love.load()
    love.window.setTitle("Space Cowa and Big Problems")
    love.graphics.setDefaultFilter("nearest", "nearest")
    StateManager.switch( states.start_game )
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
    if key == "r" then
        StateManager.switch( states.game )
    end
    if StateManager.current().keypressed then
        StateManager.current():keypressed(key)
    end
end
