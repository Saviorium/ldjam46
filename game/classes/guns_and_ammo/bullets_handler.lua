Class = require "lib.hump.class"
Vector = require "lib.hump.vector"
Bullet = require 'game/classes/guns_and_ammo/bullet'

Bullets_handler = Class {
    init = function(self)
    end,
    bullets_on_screen = {}
}

function Bullets_handler:fire( player, bullets_in_shoot, distance_between_bullets, bullets_angle )
    for bullet=1, bullets_in_shoot do
            local position_x = player.curr_pos.x + ((bullet % 2 == 0) and 1 or -1 ) * ((bullets_in_shoot % 2 ~= 0 and bullet == 1) and 0 or 1) * bullets_in_shoot
            local position_y = player.curr_pos.y
            local angle = player.angle +  ((bullet % 2 == 0) and 1 or -1 ) * ((bullets_in_shoot % 2 ~= 0 and bullet == 1) and 0 or 1) * (math.floor(bullet / 2 )) * bullets_angle
            local Bullet = Bullet( position_x, 
            					   position_y, 
            					   love.graphics.newImage('data/images/bullet.png'), 
            					   10, 
            					   angle)
            table.insert(self.bullets_on_screen, Bullet)
    end
end

function Bullets_handler:destroy_bullet( bullet_i )
    self.bullets_on_screen[bullet_i]:destroy()
    self.bullets_on_screen[bullet_i] = nil
end

function Bullets_handler:draw()
    for b_i, bullet in pairs(self.bullets_on_screen) do
        bullet:draw()
    end
end

function Bullets_handler:update( dt )
    for b_i, bullet in pairs(self.bullets_on_screen) do
        bullet:update( dt )
    end
end

return Bullets_handler