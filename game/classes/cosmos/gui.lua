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
  love.graphics.print(string.format('%.1f',self.player.inventory['iron']),
                      240*scale,
                      3*scale
                     )
  love.graphics.print(string.format('%.1f',self.player.inventory['ice']),
                      144*scale,
                      3*scale
                     )
  love.graphics.print(string.format('%.1f',self.player.inventory['oxygen']),
                      47*scale,
                      3*scale
                     )
  love.graphics.print(string.format('%.1f',self.player.inventory['energy']),
                      328*scale,
                      3*scale
                     )
  love.graphics.setFont(fonts.char)
end

return GUI