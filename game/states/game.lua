-- init/restart game

MotherShip = require "game.classes.base.mothership"
PlayerShip = require "game.classes.player-ship"
Clock = require "game.classes.clock"
debug_physics = false
TutorialWatched = false
local game = {}

motherShip = nil
playerShip = nil
clock = nil

Asteroids = nil
Destroyed_Asteroids = nil
Loot = nil

function game:enter()
    motherShip = MotherShip()
    playerShip = PlayerShip()

    clock = Clock({ year = 2013, month = 09, day = 13}, 60*60*24)
	Destroyed_Asteroids = {}
    Asteroids = {}
    Loot = {}

    StateManager.switch( states.base )
end

return game