Player = require "game/classes/cosmos/player"
BaseShip = require "game/classes/cosmos/base-ship"
Asteroid = require "game/classes/cosmos/asteroid"
Map = require "game/classes/cosmos/map/map"
GUI = require "game/classes/cosmos/gui"
Camera = require "lib.hump.camera"
HC = require 'lib/hardoncollider'
fonts = require "data.fonts"

local cosmos = {}

function cosmos:enter() -- Запускается при запуске приложения
    self.hc = HC.new()
    for _,obj in pairs(Asteroids) do
		if obj then 
			obj.hc = self.hc 
			obj:registerCollider(self.hc) 
			obj.collider.type = 'asteroid'
		end
	end
	for _,obj in pairs(Loot) do
		if obj then 
			obj.hc = self.hc
			obj:registerCollider(self.hc) 
			obj.collider.type = 'drop'
		end
	end
	self.player = Player(100, --x
					100, --y
					0, --angle
					love.graphics.newImage('data/images/shuttle.png'), 
					4, --speed
					10000, --maxVolume
					100,  -- HP
					self.hc)

	self.gui = GUI(love.graphics.newImage('data/images/guid.png'), 
				   self.player)
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
		if Vector(obj.curr_pos.x - self.player.curr_pos.x,
				  obj.curr_pos.y - self.player.curr_pos.y
				 ):len() < 300*scale then 
			obj:draw()
		end
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
    self.gui:draw()
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