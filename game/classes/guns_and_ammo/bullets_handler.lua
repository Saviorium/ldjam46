Class = require "lib.hump.class"
Vector = require "lib.hump.vector"
Bullet = require 'game/classes/guns_and_ammo/bullet'

Bullets_handler = Class {
    init = function(self, hc)
        self.hc = hc
    end,
    bullets_on_screen = {}
}

function Bullets_handler:fire( player, bullets_in_shoot, distance_between_bullets, bullets_angle )
    for bullet=1, bullets_in_shoot do
    	local direction = Vector (math.cos(player.angle), math.sin(player.angle))
    	local perpendicular = direction:perpendicular()*distance_between_bullets
        local position_x = ((bullet % 2 == 0) and 1 or -1 ) * ((bullets_in_shoot % 2 ~= 0 and bullet == 1) and 0 or 1)*perpendicular.x + player.curr_pos.x
        local position_y = ((bullet % 2 == 0) and 1 or -1 ) * ((bullets_in_shoot % 2 ~= 0 and bullet == 1) and 0 or 1)*perpendicular.y + player.curr_pos.y
        local angle = player.angle +  ((bullet % 2 == 0) and 1 or -1 ) * ((bullets_in_shoot % 2 ~= 0 and bullet == 1) and 0 or 1) * (math.floor(bullet / 2 )) * bullets_angle
        local Bullet = Bullet( position_x, 
                       position_y, 
                       love.graphics.newImage('data/images/bullet.png'), 
                       10, 
                       angle,
                       self.hc)
        table.insert(self.bullets_on_screen, Bullet)
    end
end

function Bullets_handler:draw()
    for b_i, bullet in pairs(self.bullets_on_screen) do
        bullet:draw()
    end
end

function Bullets_handler:update( dt )
    for b_i, bullet in pairs(self.bullets_on_screen) do
        bullet:update( dt )
        for shape, delta in pairs(self.hc:collisions(bullet.collider)) do
          if shape.type == 'asteroid' then 
              for index, asteroid in pairs(Asteroids) do
                local cx, cy = shape:center()
                if cx == asteroid.curr_pos.x and
                   cy == asteroid.curr_pos.y then
                  asteroid.HP = asteroid.HP - bullet.damage
                  if asteroid.HP < 0 then
                      Asteroids[index] = nil
                      asteroid:destroy()
                  end
                end
              end
            self.bullets_on_screen[b_i] = nil
            self.hc:remove(bullet.collider)
          end
        end
        if self.time_to_live == 0 then
            self.bullets_on_screen[b_i] = nil
            self.hc:remove(bullet.collider)
        end
    end
end

return Bullets_handler