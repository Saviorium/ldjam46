Class = require "lib.hump.class"
Peachy = require "lib.peachy.peachy"

Button = Class {
    init = function(self, x, y, filename, callback)
        self.x = x
        self.y = y
        local image = love.graphics.newImage("data/images/ui/"..filename..".png")
        image:setFilter("nearest", "nearest")
        sprite = Peachy.new("data/images/ui/"..filename..".json", image, "up")
        self.sprite = sprite
        self.selected = false
        self.callback = callback
    end
}

function Button:setSelected(selected)
    if selected ~= self.selected then
        if selected then
            self.sprite:setTag("selected")
        else
            self.sprite:setTag("up")
        end
        self.selected = selected
    end
end

function Button:isSelected()
    return self.selected
end

function Button:getCollision(x, y)
    return 	self.x * scale < x and
            (self.x + self.sprite:getWidth()) * scale > x and
            self.y * scale < y and
            (self.y + self.sprite:getHeight()) * scale > y
end

function Button:mousepressed()
    self.sprite:setTag("down")
end

function Button:mousereleased()
    self.sprite:setTag("up")
    if self.selected then
        self.callback()
    end
end

function Button:draw()
    self.sprite:draw(self.x, self.y, 0, scale, scale)
end

function Button:update(dt)
    self.sprite:update(dt)
end

return Button