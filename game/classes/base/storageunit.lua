Class = require "lib.hump.class"

StorageUnit = Class {
    init = function(self, max, initial, name)
        self.max = max
        self.value = initial
        self.name = name
    end
}

function StorageUnit:add(units)
    self:addAndGetExcess(units)
end

function StorageUnit:addAndGetExcess(units)
    local newValue = self.value + units
    if newValue > self.max then
        self.value = self.max
        return newValue - self.max
    end
    if newValue < 0 then
        self.value = 0
        return newValue
    end
    self.value = newValue
    return 0
end

function StorageUnit:getLevel()
    return self.value / self.max
end

function StorageUnit:getName()
    return self.name
end

function StorageUnit:getMax()
    return self.max
end

function StorageUnit:getValue()
    return self.value
end

return StorageUnit
