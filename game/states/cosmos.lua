Player = require "game/classes/player"
Asteroid = require "game/classes/asteroid"
Map = require "game/classes/map/map"
Camera = require "lib.hump.camera"
HC = require 'lib/hardoncollider'

local cosmos = {}

function cosmos:enter() -- Запускается при запуске приложения
    self.hc = HC.new()
	self.player = Player(100, --x
					100, --y
					0, --angle
					love.graphics.newImage('data/images/shuttle.png'), 
					4, --speed
					100, --maxVolume
					100,  -- HP
					self.hc)
	self.camera = Camera(self.player.curr_pos.x, self.player.curr_pos.y)
	-- self.Map = Map(love.graphics.newImage('data/images/map.png'),
	-- 			   love.graphics.newImage('data/images/map.png'),
	-- 			   love.graphics.newImage('data/images/map.png'),
	-- 			   self.player,
	-- 			   self.hc)
end

function cosmos:mousepressed(x, y)
end

function cosmos:keypressed( key ) -- кнопка нажата
end

function cosmos:draw() -- отрисовка каждый кадр
    self.camera:attach()
    --self.Map:draw()
	self.player:draw()	
	for _,obj in pairs(Asteroids) do
		obj:draw()
	end
    self.camera:detach()
end

function cosmos:update( dt ) -- Каждый кадр
	self.player:update(dt)
	for _,obj in pairs(Asteroids) do
		obj:update(dt)
	end
    local dx,dy = self.player.curr_pos.x - self.camera.x, self.player.curr_pos.y - self.camera.y
    self.camera:move(dx/2, dy/2)
    --self.Map:update(dt)
end

return cosmos