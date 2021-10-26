local Button = {}

function Button:new(x, y, width, height, object)
	object = object or {
		x = x,
		y = y,
		width = width,
		height = height
	}
	setmetatable(object, self)
	self.__index = self
	-- table.insert(globalUpdates, object)
	return object
end

function Button:isWithin(mx, my)	
	x1 = self.x
	y1 = self.y
	x2 = self.x + self.width
	y2 = self.y + self.height
	
	if (mx > x1 and mx < x2 and my > y1 and my < y2) then
		return true
	end
	return false
end

return Button