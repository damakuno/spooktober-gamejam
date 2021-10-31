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
		moving = false,
		timer = Timer:new(ticks or 1, function()			
			if object.moving == true then object:move() end
			if object.y < object.y_threshold then				
				object.visible = false
				if object.consumed == false then
					SoulPoints = SoulPoints + 10 
					object.consumed = true
				end
			end
		end),		
		y_threshold = 300,
		consumed = false,
		visible = true
    }

    setmetatable(object, self)
    self.__index = self    
    return object
end

function Child:start()
	self.image.loop = true
	self.image:start()
	self.moving = true
end

function Child:move()	
	self.y = self.y - 5
end

function Child:draw()
    if self.visible ~= true then return end	
	-- status = "child draw called"
	self.image:draw(self.x, self.y)
end

return Child
