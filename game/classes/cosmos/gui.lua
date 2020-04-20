Class = require "lib.hump.class"
fonts = require "data.fonts"

GUI = Class {
    init = function(self, image_gui, player, baseShip)
      self.image = image_gui
      self.player = player
      self.baseShip = baseShip
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
    love.graphics.print(string.format('%.1f',self.player.inventory['foodAnimal']),
                        237*scale,
                        3*scale
                       )
    love.graphics.print(string.format('%.1f',self.player.inventory['foodVeg']),
                        282*scale,
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

    temp = Vector(self.baseShip.curr_pos.x - self.player.curr_pos.x,
                  self.baseShip.curr_pos.y - self.player.curr_pos.y
                 )
    if temp:len() <= 900*scale then
        love.graphics.setColor(255, 0, 255)
        love.graphics.circle('fill',
                             (364+temp.x/80)*scale,
                             (264+temp.y/80)*scale,
                             2*scale
                            )
    else   
        temp = temp:normalized()
        love.graphics.line( (364.5 + temp.x*10)*scale , (264.5 + temp.y*10)*scale , 
                            (364.5 + temp.x*20)*scale , (264.5 + temp.y*20)*scale
                          )
    end 

    love.graphics.setColor(0, 0, 255)
    for ind, obj in pairs(asteroids_in_view) do
        love.graphics.circle('fill',
                             (365+obj.x)*scale,
                             (265+obj.y)*scale,
                             1*scale
                            )
    end
    love.graphics.setColor(0, 255, 0)
    for ind, obj in pairs(loot_in_view) do
        love.graphics.circle('fill',
                             (365+obj.x)*scale,
                             (265+obj.y)*scale,
                             1*scale
                            )
    end
    love.graphics.setColor(255, 255, 255)
    love.graphics.circle('fill',
                         364*scale,
                         264*scale,
                         1*scale
                        )
end

return GUI