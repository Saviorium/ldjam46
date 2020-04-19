Class = require "lib.hump.class"
Vector = require "lib.hump.vector"
PhysicsObject = require "game/classes/cosmos/physical_object"
Bullets_handler    = require 'game/classes/cosmos/guns_and_ammo/bullets_handler'

Player = Class {
    __includes = PhysicsObject,
    init = function(self, x, y, andgle, image, speed, maxVolume, HP, HC)
    	PhysicsObject.init(self, x, y, image)
        self.maxVolume = maxVolume

        self.maxEnergy = 100
        self.oxygenConsume = 10

        self.inventory = playerShip.inventory

        self.HP = HP
        self.angle = andgle
        self.turn_speed = 10/math.pi
        self.speed = speed
        self.strafe_speed = speed/2
        self.back_speed   = speed/10
        self.stop_speed   = 0.5

        self.rate_of_fire   = 1
        self.last_fire = 0

        self.energyOnMove = 5
        self.energyOnStrafe = 2
        self.enegryOnFireLazer = 80
        self.enegryOnFireGatling = 20
        self.energyInSecond = 3

        self.HC = HC
        self.bullets_handler = Bullets_handler(self.HC)
        self:registerCollider(self.HC)
        self.collider.type = 'player'
        self.buttons = {up    = 'w',
                        down  = 's',
                        left  = 'a',
                        right = 'd',
                        stop  = 'x',
                        fire1 = 'q',
                        fire2 = 'e',
                        use   = 'f'}
    end
}

function Player:draw()
    love.graphics.draw(self.image,
                       self.curr_pos.x,
                       self.curr_pos.y, 
                       self.angle+0.5*math.pi, 
                       scale, 
                       scale,
                       self.width/2,
                       self.height/2 )
    self.bullets_handler:draw()
    if debug_physics then self:debugDraw() end
end

function Player:update( dt )
    if self.inventory['energy'] >= self.energyOnMove then
        if love.keyboard.isDown( self.buttons['up'] ) then 
            self:speedUp( self.speed, 
                          math.cos(self.angle), 
                          math.sin(self.angle),
                          dt  
                        )
        end
        if love.keyboard.isDown( self.buttons['down'] ) then 
            self:speedUp( -self.back_speed, 
                          math.cos(self.angle), 
                          math.sin(self.angle),
                          dt 
                        )
        end
        if love.keyboard.isDown( self.buttons['left'] ) then 
            self:speedUp( self.strafe_speed, 
                          math.cos(self.angle-0.5*math.pi), 
                          math.sin(self.angle-0.5*math.pi),
                          dt  
                        )
        end
        if love.keyboard.isDown( self.buttons['right'] ) then
            self:speedUp( self.strafe_speed, 
                          math.cos(self.angle+0.5*math.pi), 
                          math.sin(self.angle+0.5*math.pi),
                          dt  
                        )
        end
        if love.keyboard.isDown( self.buttons['stop'] ) then
            self:speedUp( -1, 
                          self.cur_speed.x, 
                          self.cur_speed.y,
                          dt  
                        )
        end
    end
    if love.keyboard.isDown( self.buttons['fire1'] )
   and self.inventory['energy'] > self.enegryOnFireLazer then
        self:fireLazer()
    end
    if love.keyboard.isDown( self.buttons['fire2'] ) 
   and self.inventory['energy'] > self.enegryOnFireGatling then
        self:fireGatling()
    end
    self:setAngle(cursor, dt)
    self:onCollide()
    self:move( self.cur_speed )
    self.bullets_handler:update(dt)

    self.last_fire = self.last_fire+dt
    if self.inventory['energy'] <= self.maxEnergy then
      self.inventory['energy'] = self.inventory['energy'] + self.energyInSecond*dt
    end
    if self.inventory['oxygen'] >= 0  then
      self.inventory['oxygen'] = self.inventory['oxygen'] - self.oxygenConsume *dt
    end
end

function Player:debugDraw()
    local x = self.curr_pos.x
    local y = self.curr_pos.y
    local width,height = 200 * scale, 150 * scale
    local current_cursor = Vector((love.mouse.getX()) and x-width+love.mouse.getX()  or 0,
                                  (love.mouse.getY()) and y-height+love.mouse.getY()  or 0)
    love.graphics.setColor(0,255,0)
    love.graphics.line( x, y, x+self.cur_speed.x*10, y+self.cur_speed.y*10)
    love.graphics.setColor(255,0,0)
    love.graphics.line( x, y, x+math.cos(self.angle)*10, y+math.sin(self.angle)*10)
    love.graphics.setColor(0,0,255)
    love.graphics.line( x, y, current_cursor.x, current_cursor.y)
    love.graphics.setColor(255,255,255)
end

function Player:setAngle(cursor, dt)
    local x = self.curr_pos.x
    local y = self.curr_pos.y 
    local width,height = 200 * scale, 150 * scale  
    local direction = Vector (math.cos(self.angle), math.sin(self.angle))
    local current_cursor = Vector((love.mouse.getX()) and -width +love.mouse.getX()  or 0,
                                  (love.mouse.getY()) and -height+love.mouse.getY() or 0)
    if math.abs((direction:angleTo(current_cursor)*180)/math.pi) > 1 and math.abs((direction:angleTo(current_cursor)*180)/math.pi) < 180 then
        self.angle = self.angle + self.turn_speed*dt*((direction:angleTo(current_cursor) < 0) and 1 or -1 )
    elseif math.abs((direction:angleTo(current_cursor)*180)/math.pi) >= 180 then
        self.angle = self.angle + self.turn_speed*dt*((direction:angleTo(current_cursor) > 0) and 1 or -1 )
    end
end

function Player:speedUp( speed, angle_x, angle_y, dt)
    self.cur_speed.x = self.cur_speed.x + speed*angle_x*dt
    self.cur_speed.y = self.cur_speed.y + speed*angle_y*dt
    self.inventory['energy'] = self.inventory['energy'] - self.energyOnMove*dt
end

function Player:fireLazer()

end

function Player:fireGatling()
    if self.last_fire > self.rate_of_fire then
        self.last_fire = 0
        self.bullets_handler:fire( self, 2, self.width, 0 ) 
        self.inventory['energy'] = self.inventory['energy'] - self.enegryOnFireGatling
    end
end

function Player:checkFreeSpace()
    local freeSpace = self.maxVolume
    for type, count in pairs(self.inventory) do
      if type ~= 'energy' then
        freeSpace = freeSpace - count
      end
    end
    return freeSpace
end

function Player:enterBase()
    local iceExcess = motherShip:addResources('water', self.inventory.ice)
    self.inventory.ice = iceExcess
    local ironExcess = motherShip:addResources('iron', self.inventory.iron)
    self.inventory.iron = ironExcess
    StateManager.switch(states.base)
end

function Player:onCollide()
    for shape, delta in pairs(self.HC:collisions(self.collider)) do
      if shape.type == 'asteroid' or shape.type == 'solid' then 
        if self.cur_speed:len() > 10 then
          self.HP = self.HP - self.cur_speed:len()/10
          print(self.HP)
        end
        self.curr_pos.x = self.curr_pos.x+delta.x
        self.curr_pos.y = self.curr_pos.y+delta.y
        self.collider:move( delta.x, delta.y )
        self.cur_speed = -self.cur_speed*0.1
      end
      if shape.type == 'drop' then 
        local left = self:checkFreeSpace()
        if left > shape.count then 
          self.inventory[shape.resource] = self.inventory[shape.resource] + shape.count
          shape.count = 0
        elseif left < shape.count and left > 0 then
          shape.count = shape.count - left
          self.inventory[shape.resource] = self.inventory[shape.resource] + left_place
        end
      end
      if shape.type == "enterBase" and love.keyboard.isDown( self.buttons['use'] ) then
          self:enterBase()
      end
    end
end

return Player