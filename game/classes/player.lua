Class = require "lib.hump.class"
Vector = require "lib.hump.vector"
PhysicsObject = require "game/classes/physical_object"

Player = Class {
    __includes = PhysicsObject,
    init = function(self, x, y, andgle, image, speed, maxVolume, HP)
    	PhysicsObject.init(self, x, y, image)
        self.maxVolume = maxVolume
        self.HP = HP
        self.angle = andgle
        self.turn_speed = 10
        self.speed = speed
        self:registerCollider(HC)
    end
}

function Player:draw()
    love.graphics.draw(self.image,
                       self.curr_pos.x,
                       self.curr_pos.y, 
                       self.angle/math.pi+math.pi/2, 
                       scale, 
                       scale,
                       self.width/2,
                       self.height/2 )
    --self.collider:draw('fill')
    self:debugDraw()
end

function Player:update( dt )
    local x = self.curr_pos.x
    local y = self.curr_pos.y
    local width,height = 200 * scale, 150 * scale
    local direction = Vector (math.cos(self.angle/math.pi), math.sin(self.angle/math.pi))
    local current_cursor = Vector((love.mouse.getX()) and -width +love.mouse.getX()  or 0,
                                  (love.mouse.getY()) and -height+love.mouse.getY() or 0)
    local zero = Vector(0,
                        1)

    if love.keyboard.isDown( "up" ) then 
        self.cur_speed.x = self.cur_speed.x + self.speed*math.cos(self.angle/math.pi)*dt
        self.cur_speed.y = self.cur_speed.y + self.speed*math.sin(self.angle/math.pi)*dt
    end
    if love.keyboard.isDown( "down" ) then 
        self.cur_speed.x = self.cur_speed.x - self.speed/10*math.cos(self.angle/math.pi)*dt
        self.cur_speed.y = self.cur_speed.y - self.speed/10*math.sin(self.angle/math.pi)*dt
    end
    print((direction:angleTo(current_cursor)*180)/math.pi)
    if math.abs((direction:angleTo(current_cursor)*180)/math.pi) > 1 then
        self.angle = self.angle + self.turn_speed*dt*((direction:angleTo(current_cursor) < 0) and 1 or -1 )
    end
    -- if love.keyboard.isDown( "left" ) then 
    --     self.angle = self.angle - 10*dt
    -- end
    -- if love.keyboard.isDown( "right" ) then
    --     self.angle = self.angle + 10*dt
    -- end
    self:onCollide()
    self:move( self.cur_speed )
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
    love.graphics.line( x, y, x+math.cos(self.angle/math.pi)*10, y+math.sin(self.angle/math.pi)*10)
    love.graphics.setColor(0,0,255)
    love.graphics.line( x, y, current_cursor.x, current_cursor.y)
    love.graphics.setColor(255,255,255)
end

function angle(from, to)
    local first = from.x*to.x + from.y*to.y
    local second = from:len()*to:len()
    return math.acos(first/second)
end

return Player