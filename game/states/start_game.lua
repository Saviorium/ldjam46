texts = require "data.texts"

local start_game = {}

function start_game:enter()

end

function start_game:draw()

  	love.graphics.setFont(fonts.char)
	love.graphics.print(texts.start_text,
                        20*scale,
                        10*scale
                       )
    love.graphics.draw( Images['helpSpace'],
                        300*scale,
                        280*scale, 
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