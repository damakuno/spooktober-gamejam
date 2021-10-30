local Child = {}

function Child:new(x, y, width, height, duration, image, ticks, object)    
    object = object or {
		x = x,
		y = y,
		width = width,
		height = height,
		duration = duration or 1,
		image = image,
		ticks = ticks,
		timer = Timer:new(ticks or 1, function()			
			object:move()
		end),
		visible = true
    }


    setmetatable(object, self)
    self.__index = self    
    return object
end

function Child:start()
	self.image.loop = true
	self.image:start()
end

function Child:move()
	-- status = "move called"
	self.y = self.y - 5
end

function Child:draw()
    -- if self.visible ~= true then return end	
	status = "child draw called"
	self.image:draw(self.x, self.y)
end

return Child
