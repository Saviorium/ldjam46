Class = require "lib.hump.class"

StorageUnit = Class {
    init = function(self, max, initial)
        self.max = max
        self.value = initial
    end
}

function StorageUnit:add(units)
    local newValue = self.value + units
    self.value = math.max(0, math.min(newValue, self.max)); -- clamp(0, newValue, self.max)
end

return StorageUnit
