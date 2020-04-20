texts = require "data.texts"

local end_game = {}

function end_game:enter(prev_state, type)
    type_of_death = type
end

function end_game:draw()
	love.graphics.print(texts['end_'..type_of_death..'_theme'],
                        20*scale,
                        20*scale
                       )
	love.graphics.print(texts['end_'..type_of_death],
                        20*scale,
                        80*scale
                       )
end

function end_game:keypressed( key )
    if key == "space" then
        StateManager.switch( states.start_game )
    end
end

return end_game