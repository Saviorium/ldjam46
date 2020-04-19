Class = require "lib.hump.class"

StorageUnit = Class {
    init = function(self, max, initial, name)
        self.max = max
        self.value = initial
        self.name = name
    end
}

function StorageUnit:add(units)
    local newValue = self.value + units
    self.value = math.max(0, math.min(newValue, self.max)); -- clamp(0, newValue, self.max)
    print("oxygen" .. self.value)
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
