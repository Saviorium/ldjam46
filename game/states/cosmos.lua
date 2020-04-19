Player = require "game/classes/player"
BaseShip = require "game/classes/base-ship"
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
					10000, --maxVolume
					100,  -- HP
					self.hc)
	self.camera = Camera(self.player.curr_pos.x, self.player.curr_pos.y)
	self.map = Map(love.graphics.newImage('data/images/map.png'),
				   love.graphics.newImage('data/images/map.png'),
				   love.graphics.newImage('data/images/map.png'),
				   self.player,
				   self.hc)
	self.baseShip = BaseShip(0, 0, self.hc)
end

function cosmos:mousepressed(x, y)
end

function cosmos:keypressed( key )
end

function cosmos:draw() -- отрисовка каждый кадр
    self.camera:attach()
    self.map:draw()
	self.player:draw()
	self.baseShip:draw()	
	for _,obj in pairs(Asteroids) do
		obj:draw()
	end
	for _,obj in pairs(Loot) do
		obj:draw()
	end
	if debug_physics then
		love.graphics.setColor(0, 0, 1)
		local shapes = self.hc:hash():shapes()
		for _, shape in pairs(shapes) do
		    shape:draw()
		end
		love.graphics.setColor(255, 255, 255)
	end
    self.camera:detach()
end

function cosmos:update( dt ) -- Каждый кадр
	self.player:update(dt)
	self.baseShip:update(dt)
	for _,obj in pairs(Asteroids) do
		obj:update(dt)
	end
	for _,obj in pairs(Loot) do
		obj:update(dt)
	end
    local dx,dy = self.player.curr_pos.x - self.camera.x, self.player.curr_pos.y - self.camera.y
    self.camera:move(dx/2, dy/2)
    self.map:update(dt)
end

return cosmos