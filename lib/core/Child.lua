local Child = {}

function Child:new(x, y, width, height, duration, image, image_dead, ticks, object)    	
    object = object or {
		x = x,
		y = y,
		width = width,
		height = height,
		duration = duration or 1,
		image = image,
		image_dead = image_dead,
		ticks = ticks,
		moving = false,
		timer = Timer:new(ticks or 1, function()	
			if object.moving == true then object:move() end
			if object.y < object.y_threshold then
				-- object.visible = false
				if object.consumed == false then
					sfx.coin:play()
					SoulPoints = SoulPoints + 10
					object.consumed = true
				end
			end
		end),		
		y_threshold = 480,
		consumed = false,
		visible = true
    }

    setmetatable(object, self)
    self.__index = self    
    return object
end

function Child:start()
	-- self.image.loop = true
	-- self.image:start()
	self.image_dead.loop = true
	self.image_dead:start()
	self.moving = true
end

function Child:move()	
	self.y = self.y - 5
end

function Child:draw()
    if self.visible ~= true then return end	
	-- status = "child draw called"
	if self.consumed == true then		
		self.image_dead:draw(self.x, self.y)
	else
		self.image:draw(self.x, self.y)
	end
end

return Child
