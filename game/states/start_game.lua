texts = require "data.texts"

local start_game = {}

function start_game:enter()

end

function start_game:draw()
	for i=1, string.len(texts.start_text)/100 do
		love.graphics.print(string.sub(texts.start_text,(i-1)*100,i*100),
	                        50*scale,
	                        i*20*scale
	                       )
	end
end

function start_game:keypressed( key )
    if key == "space" then
        StateManager.switch( states.game )
    end
end

return start_game