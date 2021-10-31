local Spawner = {}

function Spawner:new(x, y, ticks, Slots, object)    
    object = object or {
		x = x,
		y = y,
		ticks = ticks or 1,
		timer = Timer:new(ticks or 1, function()
			object:getSpawnRate(Slots)
			-- 60 per minute
			if object.totalSpawnRate ~= nil then				
				object.spawnCounter = object.spawnCounter + object.totalSpawnRate
				status = "spawn counter updated: "..object.spawnCounter
				if object.spawnCounter > object.spawnAtValue then
					object.spawnCounter = 0
					object:spawn(Children.GhostChild)
				end
			end
		end),		
		spawnCounter = 0,
		spawnAtValue = 500,
		children = {},
		totalSpawnRate = 0,
		visible = true
    }

	object.timer:start()
    setmetatable(object, self)
    self.__index = self    
    return object
end

function Spawner:draw()
    if self.visible ~= true then return end
end

function Spawner:spawn(child)
	local newChild = Child:new(child.x + randomInt(-200, 200), child.y, child.width, child.height, child.duration,
	 Anime:new("child_img", child.image.spriteSheet, child.width, child.height, 1),
	 Anime:new("child_img", child.image_dead.spriteSheet, child.width, child.height, child.duration), child.ticks)
	status = "spawn function called x: "..newChild.x.." y: "..newChild.y
	newChild:start()
	table.insert(self.children, newChild)
end

function Spawner:getSpawnRate(Slots)	
	self.totalSpawnRate = 0
	for _, slot in pairs(Slots) do
		if slot.pet ~= nil then
			self.totalSpawnRate = self.totalSpawnRate + slot.pet.spawnrate			
		end
	end
	return self.totalSpawnRate
end

return Spawner
