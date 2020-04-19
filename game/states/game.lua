local game = {}
Player = require "game/classes/player"
Asteroid = require "game/classes/asteroid"
Map = require "game/classes/map/map"
Camera = require "lib.hump.camera"

function game:enter() -- Запускается при запуске приложения
	Player = Player(100, --x
					100, --y
					0, --angle
					love.graphics.newImage('data/images/shuttle.png'), 
					10, --speed
					100, --maxVolume
					100) -- HP
	camera = Camera(Player.curr_pos.x, Player.curr_pos.y)
	Map = Map(love.graphics.newImage('data/images/map.png'),
			  love.graphics.newImage('data/images/map.png'),
			  love.graphics.newImage('data/images/map.png'))
	-- Astreroids = {}
	-- for i=1, 10 do
	-- 	table.insert(Astreroids,
	-- 				 Asteroid(math.random(0,475 * scale), --x
	-- 					 	  math.random(0,300 * scale), --y
	-- 					 	  math.random(0,360), 		  --angle
	-- 					 	  love.graphics.newImage('data/images/asteroid.png')
	-- 					 	 )
	-- 	 		    )
	-- end

end

function game:mousepressed(x, y)
end

function game:keypressed( key ) -- кнопка нажата
end

function game:draw() -- отрисовка каждый кадр
    camera:attach()
    Map:draw()
	Player:draw()	
	-- for _,obj in pairs(Astreroids) do
	-- 	obj:draw()
	-- end
    camera:detach()
end

function game:update( dt ) -- Каждый кадр
	Player:update(dt)
	-- for _,obj in pairs(Astreroids) do
	-- 	obj:update(dt)
	-- end
    local dx,dy = Player.curr_pos.x - camera.x, Player.curr_pos.y - camera.y
    camera:move(dx/2, dy/2)
    Map:update(dt)
end

return game