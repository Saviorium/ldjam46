Class = require "lib.hump.class"
tracks = require "data/tracks"

UpgradesBox = Class {
    init = function(self, x, y, resource, ship)
        self.x = x
        self.y = y
        self.resource = resource
        self.ship = ship
        self.horPadding  = 30 * scale
        self.vertPadding = 30 * scale
        self.buttons = self:initButtons()
    end
}

UpgradesBox.upgrades = {
    battery  = { costs = {10, 25, 50, 75, 100, 150, 200, 250, 300, 400, 500, 600, 700, 800, 900, 1000, 1200, 1400, 1600, 1800, 2000} },
    fire     = { costs = {10, 25, 50, 75, 100, 150, 200, 250, 300, 400, 500, 600, 700, 800, 900, 1000, 1200, 1400, 1600, 1800, 2000} },
    maneur   = { costs = {10, 25, 50, 75, 100, 150, 200, 250, 300, 400, 500, 600, 700, 800, 900, 1000, 1200, 1400, 1600, 1800, 2000} },
    recharge = { costs = {10, 25, 50, 75, 100, 150, 200, 250, 300, 400, 500, 600, 700, 800, 900, 1000, 1200, 1400, 1600, 1800, 2000} },
    space    = { costs = {10, 25, 50, 75, 100, 150, 200, 250, 300, 400, 500, 600, 700, 800, 900, 1000, 1200, 1400, 1600, 1800, 2000} },
    speed    = { costs = {10, 25, 50, 75, 100, 150, 200, 250, 300, 400, 500, 600, 700, 800, 900, 1000, 1200, 1400, 1600, 1800, 2000} },
}

function UpgradesBox:initButtons()
    return {
        upgradeBattery  = self:buildUpgradeButton(self.x+self.horPadding*0, self.y+self.vertPadding*0, "battery"),
        upgradeFire     = self:buildUpgradeButton(self.x+self.horPadding*1, self.y+self.vertPadding*0, "fire"),
        upgradeManeur   = self:buildUpgradeButton(self.x+self.horPadding*2, self.y+self.vertPadding*0, "maneur"),
        upgradeRecharge = self:buildUpgradeButton(self.x+self.horPadding*0, self.y+self.vertPadding*1, "recharge"),
        upgradeSpace    = self:buildUpgradeButton(self.x+self.horPadding*1, self.y+self.vertPadding*1, "space"),
        upgradeSpeed    = self:buildUpgradeButton(self.x+self.horPadding*2, self.y+self.vertPadding*1, "speed"),
    }
end

function UpgradesBox:buildUpgradeButton(x, y, upgradeName)
    return Button(x, y, "upgrade-" .. upgradeName,
        function()
            self:doUpgrade(upgradeName)
        end)
end

function UpgradesBox:registerButtons(eventManager)
    for id, object in pairs(self.buttons) do
        eventManager:registerObject(object)
    end
end

function UpgradesBox:doUpgrade(upgradeName)
    currentLevel = self.ship.upgrade[upgradeName]
    upgradeCost = self.upgrades[upgradeName].costs[currentLevel]
    if not upgradeCost then
        print("max upgrade level for " .. upgradeName .. " level: " .. currentLevel .. " reached!")
        tracks.play_sound( tracks.list_of_sounds.error_button )
        return
    end
    if self.resource:getValue() < upgradeCost then
        print("not enough resources to upgrade " .. upgradeName .. " to level " .. currentLevel + 1)
        tracks.play_sound( tracks.list_of_sounds.error_button )
        return
    end
    self.resource:add( -upgradeCost )
    self.ship.upgrade[upgradeName] = currentLevel + 1
end

function UpgradesBox:draw()
    for id, object in pairs(self.buttons) do
        object:draw()
    end
end

return UpgradesBox