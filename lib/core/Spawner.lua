local Spawner = {}

function Spawner:new(x, y, ticks, child, Slots, object)    
    object = object or {
		x = x,
		y = y,
		ticks = ticks or 1,
		timer = Timer:new(ticks or 1, function()
			object:getSpawnRate(Slots)
		end),
		child = child, 
		children = {},
		totalSpawnRate = 0,
		visible = true
    }

    setmetatable(object, self)
    self.__index = self    
    return object
end

function Spawner:draw()
    if self.visible ~= true then return end
end

function Spawner:spawn()
	status = "spawn function called"
	local newChild = Child:new(self.child.x, self.child.y, self.child.width, self.child.height,
	self.child.duration, self.child.image, self.child.ticks)
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
end

return Spawner
