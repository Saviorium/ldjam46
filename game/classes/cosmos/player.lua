Class = require "lib.hump.class"
Vector = require "lib.hump.vector"
PhysicsObject = require "game/classes/cosmos/physical_object"
Bullets_handler = require "game/classes/cosmos/guns_and_ammo/bullets_handler"
tracks          = require "data/tracks"

Player =
    Class {
    __includes = PhysicsObject,
    init = function(self, x, y, angle, image, playerShip, hardonColliderInstance)
        self.curr_pos = Vector(x, y)
        self.cur_speed = Vector(0, 0)
        self.size = 15

        self.sprite = Images[image]
        self.sprite:setTag('stop')
        self.sprite:play()
        self.height = Images[image]:getHeight()
        self.width  = Images[image]:getWidth()

        self.playerShip = playerShip
        self.maxVolume = self.playerShip:getMaxVolume()

        self.maxEnergy = self.playerShip:getMaxEnergy()

        self.inventory = self.playerShip.inventory

        self.HP = self.playerShip.hp
        self.angle = angle

        self.base_speed = 3
        self.turn_speed = (10 + playerShip.upgrade.maneur) / math.pi
        self.speed = self.base_speed + playerShip.upgrade.speed
        self.strafe_speed = self.base_speed / 2 + playerShip.upgrade.maneur
        self.back_speed = self.base_speed / 5 + playerShip.upgrade.maneur
        self.stop_speed = 0.5 + playerShip.upgrade.maneur/10
        self.bounciness = 0.3

        self.rate_of_fire = 1 - playerShip.upgrade.fire*0.1
        self.last_fire = 0

        self.energyOnMove = 5
        self.energyOnStrafe = 2
        self.enegryOnFireLaser = 80
        self.enegryOnFireGatling = 20

        self.playingSound = nil
        self.soundTimer = 0

        self.HC = hardonColliderInstance
        self.bullets_handler = Bullets_handler(self.HC)
        self:registerCollider(self.HC)
        self.collider.type = "player"
        self.buttons = {
            up = "w",
            down = "s",
            left = "a",
            right = "d",
            stop = "x",
            fire1 = "q",
            fire2 = "e",
            use = "f"
        }
    end
}

function Player:registerCollider(hc_instance)
    self.collider = hc_instance:circle(self.curr_pos.x, self.curr_pos.y, self.size * scale / 2.5) -- smaller hitbox
end

function Player:draw()
    self.sprite:draw(self.curr_pos.x, self.curr_pos.y, self.angle + 0.5 * math.pi, scale, scale, self.size/2, self.size/2)
    self.bullets_handler:draw()
    if debug_physics then
        self:debugDraw()
    end
end

function Player:mouse_click()
    self:fireGatling()
end

function Player:update(dt)
    self.sprite:update(dt)
    if self.inventory["energy"] >= self.energyOnMove then
        if love.keyboard.isDown(self.buttons["up"]) then
            self.sprite:setTag('forward')
            self:speedUp(self.speed, math.cos(self.angle), math.sin(self.angle), dt)
        else
            self.sprite:setTag('stop')
        end
        if love.keyboard.isDown(self.buttons["down"]) then
            self:speedUp(-self.back_speed, math.cos(self.angle), math.sin(self.angle), dt)
        end
        if love.keyboard.isDown(self.buttons["left"]) then
            self:speedUp(
                self.strafe_speed,
                math.cos(self.angle - 0.5 * math.pi),
                math.sin(self.angle - 0.5 * math.pi),
                dt
            )
        end
        if love.keyboard.isDown(self.buttons["right"]) then
            self:speedUp(
                self.strafe_speed,
                math.cos(self.angle + 0.5 * math.pi),
                math.sin(self.angle + 0.5 * math.pi),
                dt
            )
        end
        if love.keyboard.isDown(self.buttons["stop"]) then
            self:speedUp(-1, self.cur_speed.x, self.cur_speed.y, dt)
        end
    end

    self:setAngle(cursor, dt)
    self:onCollide()
    self:move(self.cur_speed)
    self.bullets_handler:update(dt)

    self.last_fire = self.last_fire + dt

    if self.playingSound then
        if not self.playingSound:isPlaying() then
            self.playingSound = nil
        end
    end
    self.playerShip:update(dt)
end

function Player:debugDraw()
    local x = self.curr_pos.x
    local y = self.curr_pos.y
    local width, height = love.graphics.getWidth() / 2, love.graphics.getHeight() / 2
    local current_cursor =
        Vector(
        (love.mouse.getX()) and x - width + love.mouse.getX() or 0,
        (love.mouse.getY()) and y - height + love.mouse.getY() or 0
    )
    love.graphics.setColor(0, 255, 0)
    love.graphics.line(x, y, x + self.cur_speed.x * 10, y + self.cur_speed.y * 10)
    love.graphics.setColor(255, 0, 0)
    love.graphics.line(x, y, x + math.cos(self.angle) * 10, y + math.sin(self.angle) * 10)
    love.graphics.setColor(0, 0, 255)
    love.graphics.line(x, y, current_cursor.x, current_cursor.y)
    love.graphics.setColor(255, 255, 255)
end



function Player:setAngle(cursor, dt)
    local x = self.curr_pos.x
    local y = self.curr_pos.y
    local width, height = love.graphics.getWidth() / 2, love.graphics.getHeight() / 2
    local direction = Vector(math.cos(self.angle), math.sin(self.angle))
    local current_cursor =
        Vector(
        (love.mouse.getX()) and -width + love.mouse.getX() or 0,
        (love.mouse.getY()) and -height + love.mouse.getY() or 0
    )
    if
        math.abs((direction:angleTo(current_cursor) * 180) / math.pi) > 1 and
            math.abs((direction:angleTo(current_cursor) * 180) / math.pi) < 180
     then
        self.angle = self.angle + self.turn_speed * dt * ((direction:angleTo(current_cursor) < 0) and 1 or -1)
    elseif math.abs((direction:angleTo(current_cursor) * 180) / math.pi) >= 180 then
        self.angle = self.angle + self.turn_speed * dt * ((direction:angleTo(current_cursor) > 0) and 1 or -1)
    end
end

function Player:speedUp(speed, angle_x, angle_y, dt)
    self.cur_speed.x = self.cur_speed.x + speed * angle_x * dt
    self.cur_speed.y = self.cur_speed.y + speed * angle_y * dt
    self.inventory["energy"] = self.inventory["energy"] - self.energyOnMove * dt
    tracks.play_sound( tracks.list_of_sounds.engine )
end

function Player:fireLazer()
end

function Player:fireGatling()
    if self.last_fire > self.rate_of_fire and self.inventory['energy'] > self.enegryOnFireGatling then
        self.last_fire = 0
        self.bullets_handler:fire(self, 2, self.width, 0)
        self.inventory["energy"] = self.inventory["energy"] - self.enegryOnFireGatling
        tracks.play_sound( tracks.list_of_sounds.shoot_1 )
    end
end

function Player:getFreeSpace()
    return self.playerShip:getFreeSpace()
end

function Player:enterBase()
    local iceExcess = motherShip:addResources("water", self.inventory.ice)
    self.inventory.ice = iceExcess
    local ironExcess = motherShip:addResources("iron", self.inventory.iron)
    self.inventory.iron = ironExcess
    StateManager.switch(states.base)
end

function Player:onCollide()
    for shape, delta in pairs(self.HC:collisions(self.collider)) do
        if shape.type == "asteroid" or shape.type == "solid" then
            if self.cur_speed:len() > 10 then
                self.HP = self.HP - self.cur_speed:len()
                if self.HP < 0 then
                    StateManager.switch(states.end_game,1)
                end
            end
            self.curr_pos.x = self.curr_pos.x + delta.x
            self.curr_pos.y = self.curr_pos.y + delta.y
            self.collider:move(delta.x, delta.y)
            if self.cur_speed:len() > 0.5 then 
                self.cur_speed = -self.cur_speed * self.bounciness
            end
        end
        if shape.type == "drop" then
            local spaceLeft = self:getFreeSpace()
            if spaceLeft > shape.count then
                self.inventory[shape.resource] = self.inventory[shape.resource] + shape.count
                shape.count = 0
                if not self.playingSound then
                    self.playingSound = tracks.play_sound( tracks.list_of_sounds.vacuum_get )
                end            
            elseif spaceLeft < shape.count and spaceLeft > 0 then
                shape.count = shape.count - spaceLeft
                self.inventory[shape.resource] = self.inventory[shape.resource] + spaceLeft
                if not self.playingSound then
                    self.playingSound = tracks.play_sound( tracks.list_of_sounds.vacuum_get )
                end
            end
        end
        if shape.type == "enterBase" and love.keyboard.isDown(self.buttons["use"]) then
            self:enterBase()
            self.playerShip.inventory.energy = self.playerShip:getMaxEnergy()
        end
    end
end

function Player:drawHelp()
    local x, y = self.curr_pos.x-self.width, self.curr_pos.y-self.height
    love.graphics.print( self.buttons.up..' to move forward',
                        x,
                        y-16*scale,
                        0)
    love.graphics.print( self.buttons.down..' to slow down',
                        x,
                        y+16*scale,
                        0)
    love.graphics.print( self.buttons.right..' to strafe right',
                        x+16*scale,
                        y,
                        0)
    love.graphics.print( 'To strafe left '..self.buttons.left,
                        x-9*(12*scale),
                        y,
                        0) 
    love.graphics.print( 'Left mouse click to fire',
                        x,
                        y+27*scale,
                        0)
    love.graphics.print( self.buttons.stop..' to stop slowly',
                        x,
                        y-27*scale,
                        0)
    love.graphics.print( 'Press H to get help',
                        x,
                        y+36*scale,
                        0)
end

return Player
