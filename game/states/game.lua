-- init/restart game

MotherShip = require "game.classes.base.mothership"
Clock = require "game.classes.clock"
debug_physics = true
local game = {}

motherShip = nil
clock = nil

Asteroids = nil
Loot = nil

function game:enter()
    motherShip = MotherShip()
    clock = Clock({ year = 2013, month = 09, day = 13}, 60*60*24)

    Asteroids = {}
    Loot = {}

    StateManager.switch( states.base )
end

return game