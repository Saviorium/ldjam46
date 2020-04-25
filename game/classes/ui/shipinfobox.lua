Class = require "lib.hump.class"
UpgradesBox = require "game.classes.ui.upgradesbox"

ShipInfoBox = Class {
    init = function(self, x, y, playerShip, motherShip)
        self.curr_pos = Vector( x, y )
        self.playerShip = playerShip
        self.motherShip = motherShip

        self.upgradesBox = UpgradesBox(self.curr_pos.x+13, self.curr_pos.y+2, self.motherShip.storage.iron, self.playerShip)
        self:initUI()
    end
}

function ShipInfoBox:initUI()
    self.imageBack = Images['shipInfoBox']
    self.imageShipIcon = Images['shipIcon']
end

function ShipInfoBox:registerButtons(eventManager)
    self.upgradesBox:registerButtons(eventManager)
end

function ShipInfoBox:update(dt)
end

function ShipInfoBox:draw()
    -- background
    love.graphics.draw(
        self.imageBack,
        self.curr_pos.x*scale,
        self.curr_pos.y*scale,
        0,
        scale,
        scale
    )
    -- ship icon
    love.graphics.draw(
        self.imageShipIcon,
        (self.curr_pos.x+282)*scale,
        (self.curr_pos.y+3)*scale, 
        0, 
        scale, 
        scale
    )

    love.graphics.setFont(fonts.char)
    love.graphics.setColor(1, 1, 1)
    -- ship cargo text: 100/1000    
    love.graphics.print(
        self.playerShip:getFreeSpaceText(),
        (self.curr_pos.x+257)*scale,
        (self.curr_pos.y+31)*scale,
        0
    )

    -- Upgrade buttons
    self.upgradesBox:draw()
end

return ShipInfoBox