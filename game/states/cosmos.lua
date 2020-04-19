Player = require "game/classes/player"
Asteroid = require "game/classes/asteroid"
Map = require "game/classes/map/map"
Camera = require "lib.hump.camera"
HC = require 'lib/hardoncollider'

local cosmos = {}

function cosmos:enter() -- Запускается при запуске приложения
    HC = HC.new()
	Player = Player(100, --x
					100, --y
					0, --angle
					love.graphics.newImage('data/images/shuttle.png'), 
					4, --speed
					100, --maxVolume
					100) -- HP
	camera = Camera(Player.curr_pos.x, Player.curr_pos.y)
	Map = Map(love.graphics.newImage('data/images/map.png'),
			  love.graphics.newImage('data/images/map.png'),
			  love.graphics.newImage('data/images/map.png'))
end

function cosmos:mousepressed(x, y)
end

function cosmos:keypressed( key ) -- кнопка нажата
end

function cosmos:draw() -- отрисовка каждый кадр
    camera:attach()
    Map:draw()
	Player:draw()	
	for _,obj in pairs(Astreroids) do
		obj:draw()
	end
    camera:detach()
end

function cosmos:update( dt ) -- Каждый кадр
	Player:update(dt)
	-- for _,obj in pairs(Astreroids) do
	-- 	obj:update(dt)
	-- end
    local dx,dy = Player.curr_pos.x - camera.x, Player.curr_pos.y - camera.y
    camera:move(dx/2, dy/2)
    Map:update(dt)
end

return cosmos