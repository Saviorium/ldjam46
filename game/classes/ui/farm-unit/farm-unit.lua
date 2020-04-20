FarmUnit = Class {
    init = function(sprite, minX, maxX, maxY, minY)
        self.sprite = sprite
        self.x = math.random(minX, maxX)
        self.y = math.random(minY, maxY)
    end
}

function FarmUnit:draw()
    self.sprite:draw()
end
