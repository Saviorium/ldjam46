Class = require "lib.hump.class"
fonts = require "data.fonts"

SpaceUI =
    Class {
    init = function(self, player, baseShip)
        self.image = Images['space_ui']
        self.background = Images['space_ui_bg']
        self.playerShip = player.playerShip
        self.player = player
        self.baseShip = baseShip

        self.blinkRate = 1 -- per second
        self.blinkState = 0
        self.critical = { food = false, oxygen = false, space = false, energy = false, hp = false }
    end
}

function SpaceUI:update(dt)
    self.blinkState = (self.blinkState + dt * self.blinkRate) % 1

    self.critical.food = self.playerShip:getFood() < 10
    self.critical.oxygen = self.playerShip:getOxygen() < 20
    self.critical.space = self.playerShip:getFreeSpace() < 1
    self.critical.energy = self.playerShip:getEnergy() < 9
    self.critical.hp = self.playerShip:getHP() < 10
end

function SpaceUI:draw()
    self:drawBlinkingBackground()
    love.graphics.setFont(fonts.char)
    love.graphics.draw(self.image, 0, 0, 0, scale, scale)
    love.graphics.print(string.format("%3.f", math.clamp(0, self.playerShip:getFood(), 9999)), 70 * scale, 6 * scale)
    love.graphics.print(string.format("%3.f", math.clamp(0, self.playerShip:getOxygen(), 9999)), 127 * scale, 6 * scale)
    love.graphics.print(self.playerShip:getFreeSpaceText(), 184 * scale, 6 * scale)
    love.graphics.print(string.format("%3.f", math.clamp(0, self.playerShip:getEnergy(), 9999)), 271 * scale, 6 * scale)
    love.graphics.print(string.format("%3.f", math.clamp(0, self.playerShip:getHP(), 9999)), 328 * scale, 6 * scale)
    self:drawMap()
    love.graphics.setFont(fonts.char)
end

function SpaceUI:drawBlinkingBackground()
    love.graphics.draw(self.background, 0, 0, 0, scale, scale)
    love.graphics.setColor(0.81, 0.27, 0.28)
    print(serpent.block(self.critical))
    if self.blinkState > 0.5 then
        if self.critical.food then
            self:drawRect(65, 3, 33, 18)
        end
        if self.critical.oxygen then
            self:drawRect(122, 3, 33, 18)
        end
        if self.critical.energy then
            self:drawRect(266, 3, 33, 18)
        end
        if self.critical.hp then
            self:drawRect(323, 3, 33, 18)
        end
    end

    if self.critical.space then
        self:drawRect(179, 3, 63, 18)
    end
    love.graphics.setColor(1, 1, 1)
end

function SpaceUI:drawRect(x, y, w, h)
    love.graphics.rectangle("fill", x * scale, y * scale, w * scale, h * scale)
end

function SpaceUI:drawMap()
    local temp
    asteroids_in_view = {}
    for _, obj in pairs(Asteroids) do
        temp = Vector(obj.curr_pos.x - self.player.curr_pos.x, obj.curr_pos.y - self.player.curr_pos.y)
        if temp:len() <= 900 * scale then
            table.insert(asteroids_in_view, temp / 80)
        end
    end
    loot_in_view = {}
    for _, obj in pairs(Loot) do
        local temp = Vector(obj.curr_pos.x - self.player.curr_pos.x, obj.curr_pos.y - self.player.curr_pos.y)
        if temp:len() <= 900 * scale then
            table.insert(loot_in_view, temp / 80)
        end
    end

    temp = Vector(self.baseShip.curr_pos.x - self.player.curr_pos.x, self.baseShip.curr_pos.y - self.player.curr_pos.y)
    if temp:len() <= 900 * scale then
        love.graphics.setColor(255, 0, 255)
        love.graphics.circle("fill", (364 + temp.x / 80) * scale, (264 + temp.y / 80) * scale, 2 * scale)
    else
        temp = temp:normalized()
        love.graphics.line(
            (364.5 + temp.x * 10) * scale,
            (264.5 + temp.y * 10) * scale,
            (364.5 + temp.x * 20) * scale,
            (264.5 + temp.y * 20) * scale
        )
    end

    love.graphics.setColor(0, 0, 255)
    for ind, obj in pairs(asteroids_in_view) do
        love.graphics.circle("fill", (365 + obj.x) * scale, (265 + obj.y) * scale, 1 * scale)
    end
    love.graphics.setColor(0, 255, 0)
    for ind, obj in pairs(loot_in_view) do
        love.graphics.circle("fill", (365 + obj.x) * scale, (265 + obj.y) * scale, 1 * scale)
    end
    love.graphics.setColor(255, 255, 255)
    love.graphics.circle("fill", 364 * scale, 264 * scale, 1 * scale)
end

return SpaceUI
