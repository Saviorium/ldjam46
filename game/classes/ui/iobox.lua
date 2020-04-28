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
    self.image_arrow = Peachy.new("data/images/ui/arrow-sheet.json", Images['arrow-sheet'], "normal")
    self.angle_of_arrow = (self.direction == 'Out' and math.pi or 0)
    self.image_resource = Images[self.resource]
    self.screen = Images['screen']
end

function IOBox:update(dt)
    self.image_arrow:update(dt)
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
    if self.direction == "In" then
        print(self.resource.." "..self.image_arrow.tagName.." "..self.image_arrow.frameIndex)
        local res = self.module.resources[self.resource]
        if (self.image_arrow.tagName ~= "normal") and
                res['rate']*res['consume_by_unit']*self.module.units*5 <= res['storageUnit'].value then
            self.image_arrow:setTag("normal")
        end
        if (self.image_arrow.tagName ~= "alert") and
                res['rate']*res['consume_by_unit']*self.module.units*5 > res['storageUnit'].value then
            self.image_arrow:setTag("alert")
        end
        if (self.image_arrow.tagName ~= "empty") and res['storageUnit'].value == 0 then
            self.image_arrow:setTag("empty")
        end
    end
    self.image_arrow:draw(self.curr_pos.x + (self.angle_of_arrow==0 and 32*scale or 55*scale),
                     self.curr_pos.y + (self.angle_of_arrow==0 and 5*scale  or 13*scale),
                     self.angle_of_arrow,
                     scale,
                     scale)
    love.graphics.draw(self.screen,
                       self.curr_pos.x+31*scale,
                       self.curr_pos.y+14*scale, 
                       0, 
                       scale, 
                       scale)

    love.graphics.setFont(fonts.char)
    love.graphics.setColor(1, 1, 1)
    local level = 0
    if self.module.resources[self.resource] then
        level = self.module.resources[self.resource]['rate']
    end
    love.graphics.print(string.format('%3.f',level*100)..'%',
                        self.curr_pos.x+35*scale,
                        self.curr_pos.y+17*scale,
                        0
                       )
    love.graphics.setColor(255, 255, 255)

end

function IOBox:draw()
    self:drawBox()
end

return IOBox