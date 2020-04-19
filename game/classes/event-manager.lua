Class = require "lib.hump.class"

EM = Class {
	init = function(self)
		self.objects = {}
    end
}

function EM:registerObject(object)
	table.insert(self.objects, object)
end

function EM:update()
	local currentCursor = {
		x = (love.mouse.getX()) and love.mouse.getX() or 0,
		y = (love.mouse.getY()) and love.mouse.getY() or 0
	}
	for _, object in pairs(self.objects) do
		if object:getCollision( currentCursor.x, currentCursor.y ) then
			object:setSelected(true)
	    else
			object:setSelected(false)
		end
	end
end

function EM:mousepressed()
	for _, object in pairs(self.objects) do
		if object:isSelected() then
			object:mousepressed()
	    end
	end
end

function EM:mousereleased()
	for _, object in pairs(self.objects) do
		object:mousereleased()
	end
end

return EM