Class = require "lib.hump.class"
Peachy = require "lib.peachy.peachy"
Button = require "game.classes.ui.button"

ButtonPlus = Class {
    __includes = Button,
    init = function(self, x, y)
        local image = love.graphics.newImage("data/images/ui/button-plus.png")
        image:setFilter("nearest", "nearest")
        sprite = Peachy.new("data/images/ui/button-plus.json", image, "up")
        Button.init(self, x, y, sprite)
    end
}

return ButtonPlus
