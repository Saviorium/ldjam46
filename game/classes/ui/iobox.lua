Class = require "lib.hump.class"

IOBox = Class {
    init = function(self, x, y, direction, resource, module)
        self.curr_pos = Vector( x, y )
        self.direction = direction
        self.resource = resource
        self.module = module
        self:initUI()
    end
}

function IOBox:initUI()
    self.image_back = Images['IOBox']
    self.image_arrow = Images['arrow']
    self.angel_of_arrow = (self.direction == 'In' and math.pi or 0)
    self.image_resource = Images[self.resource]
    self.screen = Images['screen']
end

function IOBox:update(dt)
end

function IOBox:drawBox()
    love.graphics.draw(self.image_back,
                       self.curr_pos.x,
                       self.curr_pos.y, 
                       0, 
                       scale, 
                       scale)
    love.graphics.draw(self.image_resource,
                       self.curr_pos.x+3*scale,
                       self.curr_pos.y+3*scale, 
                       0, 
                       scale, 
                       scale)
    love.graphics.draw(self.image_arrow,
                       self.curr_pos.x+ (self.angel_of_arrow==0 and 32*scale or 55*scale),
                       self.curr_pos.y+ (self.angel_of_arrow==0 and 5*scale  or 13*scale), 
                       self.angel_of_arrow, 
                       scale, 
                       scale)
    love.graphics.draw(self.screen,
                       self.curr_pos.x+29*scale,
                       self.curr_pos.y+14*scale, 
                       0, 
                       scale, 
                       scale)

    love.graphics.setFont(fonts.numbers)
    love.graphics.setColor(0, 0, 0)
    local level = 0
    if self.module.resources[self.resource] then
        level = self.module.resources[self.resource]['rate']
    end
    love.graphics.print((level*100)..'%',
                        self.curr_pos.x+30*scale,
                        self.curr_pos.y+18*scale,
                        0,
                        scale,
                        scale
                       )
    love.graphics.setColor(255, 255, 255)

end

function IOBox:draw()
    self:drawBox()
end

return IOBox