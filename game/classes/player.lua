Class = require "lib.hump.class"
Vector = require "lib.hump.vector"
PhysicsObject = require "game/classes/physical_object"
Bullets_handler    = require 'game/classes/guns_and_ammo/bullets_handler'

Player = Class {
    __includes = PhysicsObject,
    init = function(self, x, y, andgle, image, speed, maxVolume, HP)
    	PhysicsObject.init(self, x, y, image)
        self.maxVolume = maxVolume
        self.HP = HP
        self.angle = andgle
        self.turn_speed = 10/math.pi
        self.speed = speed
        self.strafe_speed = speed/2
        self.back_speed   = speed/10
        self.stop_speed   = 0.5
        self:registerCollider(HC)
        self.buttons = {up    = 'w',
                        down  = 's',
                        left  = 'a',
                        right = 'd',
                        stop  = 'space',
                        fire1 = 'q',
                        fire2 = 'e'}
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
    Bullets_handler:draw()
    self:debugDraw()
end

function Player:update( dt )
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

    if love.keyboard.isDown( self.buttons['fire1'] ) then
        self:fireLazer()
    end
    if love.keyboard.isDown( self.buttons['fire2'] ) then
        self:fireGatling()
    end
    self:setAngle(cursor, dt)
    self:onCollide()
    self:move( self.cur_speed )
    Bullets_handler:update(dt)
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
end

function Player:fireLazer()

end

function Player:fireGatling()
    Bullets_handler:fire( self, 2, self.width/2, 0 ) 
end

return Player