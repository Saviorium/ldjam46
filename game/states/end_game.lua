texts = require "data.texts"

local end_game = {}

function end_game:enter()

end

function end_game:draw()
	love.graphics.print(texts.end_bad1_theme,
                        50*scale,
                        20*scale
                       )
	love.graphics.print(texts.end_bad1,
                        50*scale,
                        50*scale
                       )
end

function end_game:keypressed( key )
    if key == "space" then
        StateManager.switch( states.start_game )
    end
end

return end_game