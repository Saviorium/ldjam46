Class = require "lib.hump.class"

Clock = Class {
    init = function(self, initDate, secPerRealSec)
        self.time = os.time(initDate)
        self.rate = secPerRealSec
        self.dateFormat = "%d.%m.%Y"
    end
}

function Clock:tostring()
    return os.date(self.dateFormat, self.time)
end

function Clock:update(dt)
    self.time = self.time + dt * rate
end

return Clock