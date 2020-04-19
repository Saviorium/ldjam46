Class = require "lib.hump.class"
fonts = require "data.fonts"

GUI = Class {
    init = function(self, image_gui, player)
      self.image = image_gui
      self.player = player
    end
}

function GUI:draw()
    love.graphics.setFont(fonts.numbers)
    love.graphics.draw(self.image,
                       0,
                       0, 
                       0, 
                       scale, 
                       scale)
    love.graphics.print(string.format('%.1f',self.player.inventory['oxygen']),
                        47*scale,
                        3*scale
                       )
    love.graphics.print(string.format('%.1f',self.player.inventory['ice']),
                        91*scale,
                        3*scale
                       )
    love.graphics.print(string.format('%.1f',self.player.inventory['iron']),
                        141*scale,
                        3*scale
                       )
    love.graphics.print(string.format('%.1f',self.player.inventory['food']),
                        187*scale,
                        3*scale
                       )
    love.graphics.print(string.format('%.1f',self.player.inventory['energy']),
                        328*scale,
                        3*scale
                       )
    self:drawMap()
    love.graphics.setFont(fonts.char)
end

function GUI:drawMap()

    local temp 
    asteroids_in_view = {}
    for _,obj in pairs(Asteroids) do
        temp = Vector(obj.curr_pos.x - self.player.curr_pos.x,
                      obj.curr_pos.y - self.player.curr_pos.y
                     )
        if temp:len() <= 900*scale then 
          table.insert(asteroids_in_view, temp/80)
        end
    end
    loot_in_view = {}
    for _,obj in pairs(Loot) do
      local
        temp = Vector(obj.curr_pos.x - self.player.curr_pos.x,
                      obj.curr_pos.y - self.player.curr_pos.y
                     )
        if temp:len() <= 900*scale then 
          table.insert(loot_in_view, temp/80)
        end
    end

    love.graphics.setColor(0, 0, 255)
    for ind, obj in pairs(asteroids_in_view) do
        love.graphics.circle('fill',
                             (360+obj.x)*scale,
                             (265+obj.y)*scale,
                             1
                            )
    end
    love.graphics.setColor(0, 255, 0)
    for ind, obj in pairs(loot_in_view) do
        love.graphics.circle('fill',
                             (365+obj.x)*scale,
                             (265+obj.y)*scale,
                             1
                            )
    end
    love.graphics.setColor(255, 255, 255)
    love.graphics.circle('fill',
                     365*scale,
                     265*scale,
                     1
                    )
end

return GUI