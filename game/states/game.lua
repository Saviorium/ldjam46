-- init/restart game

MotherShip = require "game.classes.base.mothership"
PlayerShip = require "game.classes.player-ship"
Clock = require "game.classes.clock"
debug_physics = false
local game = {}

motherShip = nil
playerShip = nil
clock = nil

Asteroids = nil
Loot = nil

function game:enter()
    motherShip = MotherShip()
    playerShip = PlayerShip()

    clock = Clock({ year = 2013, month = 09, day = 13}, 60*60*24)

    Asteroids = {}
    Loot = {}

    StateManager.switch( states.base )
end

return game