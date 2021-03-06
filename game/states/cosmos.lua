Player = require "game/classes/cosmos/player"
BaseShip = require "game/classes/cosmos/base-ship"
Asteroid = require "game/classes/cosmos/asteroid"
Map = require "game/classes/cosmos/map/map"
SpaceUI = require "game/classes/cosmos/ui/spaceui"
Camera = require "lib.hump.camera"
HC = require 'lib/hardoncollider'
fonts = require "data.fonts"

local cosmos = {}

function cosmos:enter() -- Запускается при запуске приложения
    self.hc = HC.new()
    for _,obj in pairs(Asteroids) do
        if obj then
            obj.hc = self.hc
            self.hc:register(obj.collider)
            obj.collider.type = 'asteroid'
        end
    end
    for _,obj in pairs(Loot) do
        if obj then
            if obj.collider then
                obj.hc = self.hc
                self.hc:register(obj.collider)
                obj.collider.type = 'drop'
            end
        end
    end
    self.player = Player(
        100, --x
        100, --y
        0, --angle
        'shuttle',
        playerShip,
        self.hc)

    self.camera = Camera(self.player.curr_pos.x, self.player.curr_pos.y)
    self.map = Map(love.graphics.newImage('data/images/map.png'),
                   self.player,
                   self.baseShip,
                   self.hc)
    self.baseShip = BaseShip(0, 0, self.hc)
    self.gui = SpaceUI(self.player, self.baseShip)
    if not TutorialWatched then
        self.timer_for_buttons = 5
    end 
end

function cosmos:mousepressed(x, y)
    self.player:mouse_click()
end

function cosmos:keypressed( key )
    
end

function cosmos:draw() -- отрисовка каждый кадр
    local height = love.graphics.getHeight()
    self.camera:attach()
    self.map:draw()
    self.player:draw()
    self.baseShip:draw()
    for _,obj in pairs(Asteroids) do
        if Vector(obj.curr_pos.x - self.player.curr_pos.x,
                  obj.curr_pos.y - self.player.curr_pos.y
                 ):len() <= height then
            obj:draw()
        end
    end
    for _,obj in pairs(Loot) do
        if Vector(obj.curr_pos.x - self.player.curr_pos.x,
                  obj.curr_pos.y - self.player.curr_pos.y
                 ):len() <= height then
            obj:draw()
        end
    end
    if debug_physics then
        love.graphics.setColor(0, 0, 1)
        local shapes = self.hc:hash():shapes()
        for _, shape in pairs(shapes) do
            shape:draw()
        end
        love.graphics.setColor(255, 255, 255)
    end
    if self.timer_for_buttons > 0 or love.keyboard.isDown('h') then
        self.player:drawHelp()
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
    motherShip:update(dt)
    if self.timer_for_buttons > 0 then
        self.timer_for_buttons = self.timer_for_buttons - dt
    else
        TutorialWatched = true
    end
    self.gui:update(dt)
end

return cosmos