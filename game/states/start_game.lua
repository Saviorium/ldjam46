texts = require "data.texts"

local start_game = {}

function start_game:enter()

end

function start_game:draw()

  	love.graphics.setFont(fonts.char)
	love.graphics.print(texts.start_text,
                        20*scale,
                        20*scale
                       )
    love.graphics.draw(
        Images['helpSpace'],
        155*scale,
        264*scale, 
        0, 
        scale, 
        scale
    )
end

function start_game:keypressed( key )
    if key == "space" then
        StateManager.switch( states.game )
    end
end

return start_game