Class = require "lib.hump.class"
Peachy = require "lib.peachy.peachy"
Button = require "game.classes.ui.button"

ButtonPlus = Class {
    __includes = Button,
    init = function(self, x, y, filename, callback)
        local image = love.graphics.newImage("data/images/ui/"..filename..".png")
        image:setFilter("nearest", "nearest")
        sprite = Peachy.new("data/images/ui/"..filename..".json", image, "up")
        Button.init(self, x, y, callback, sprite)
    end
}

return ButtonPlus
