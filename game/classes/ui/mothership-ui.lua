Class = require "lib.hump.class"
IOBox = require "game.classes.ui.iobox"
IOSetting = require "game.classes.ui.iosetting"

MotherShipUI = Class {
    init = function(self, motherShip)
        self.motherShip = motherShip
        self.modules = {}
        self.buttons = {}
        self:initUI()

        local image_screen = love.graphics.newImage("data/images/ui/bgndscreen/screen.png")
        image_screen:setFilter("nearest", "nearest")
        sprite = Peachy.new("data/images/ui/bgndscreen/screen.json", image_screen, "loop")
        self.sprite = sprite
    end
}

function MotherShipUI:initUI()
    local button = Button(160, 25, "button-plus", function() self.motherShip:addMaxVegFarm() end)
    table.insert(self.buttons, button)

    local i = 0
    for id, object in pairs(motherShip:getModules()) do
        i = i+1
        table.insert(self.buttons, Button(10*scale, (20 + 20*(i))*scale, "button-plus", function() motherShip:changeWantedMaxUnitInFarm(object, 1) end) )
        table.insert(self.buttons, Button(25*scale, (20 + 20*(i))*scale, "button-minus", function() motherShip:changeWantedMaxUnitInFarm(object, -1) end) )
    end
    local x = 141*scale
    self.IOBoxes = {
    OxygenBox_in    = IOBox( x, 15*scale, 'In', 'oxygen', self.motherShip.modules['animalFarm']),
    VegFoodBox_in   = IOSetting( x, 46*scale, 'In', 'foodVeg', self.motherShip.modules['animalFarm']),
    MeatFoodBox_out = IOBox( x, 77*scale, 'Out', 'foodAnimal', self.motherShip.modules['animalFarm']),

    WaterBox_in    = IOSetting( x, 108*scale, 'In', 'water', self.motherShip.modules['vegFarm']),
    OxygenBox_out  = IOBox( x, 139*scale, 'Out', 'oxygen', self.motherShip.modules['vegFarm']),
    VegFoodBox_out = IOBox( x, 170*scale, 'Out', 'foodVeg', self.motherShip.modules['vegFarm'])
    }

end

function MotherShipUI:registerButtons(eventManager)
    for id, iobox in pairs(self.IOBoxes) do
        if iobox.registerButtons then
            iobox:registerButtons(eventManager)
        end
    end
end

function MotherShipUI:update(dt)
    self.sprite:update(dt)
end

function MotherShipUI:onTag(sprite)
    if (sprite.frameIndex == #sprite.tag.frames) and (sprite.tagName == "loop1" or sprite.tagName == "loop2") then
        sprite:setTag("loop")
    end
end

function MotherShipUI:draw()
    if self.sprite.tagName == "loop" then
        i = math.random(0,1000)
        if i == 1 then
            sprite:setTag("loop1")
        end
        if i == 2 then
            sprite:setTag("loop2")
        end
    end
    self.sprite:onLoop(MotherShipUI:onTag(self.sprite))
    self.sprite:draw(0, 0, 0, scale, scale)
    for id, object in pairs(self.modules) do
        object:draw()
    end
    for id, object in pairs(self.buttons) do
        object:draw()
    end
    local i = 0
    for id, object in pairs(motherShip:getStorage()) do
        i = i+1
        love.graphics.print(object:getName(), 10, 20*i)
        love.graphics.print(object:getValue(), 80, 20*i)
        love.graphics.print(object:getMax(), 150, 20*i)
    end
    i = -1
    for id, object in pairs(motherShip:getModules()) do
        i = i+1
        love.graphics.print(object:getName()..": "..object:getCurrentUnits().."/"..object:getWantedMaxUnit().."(max: "..object:getMaxUnit()..")", 45*scale, (25 + 20*(i))*scale)
        object:drawFarm( 15*scale, (15+i*95)*scale )
    end
    for id, object in pairs(self.IOBoxes) do
        object:draw()
    end
end

return MotherShipUI