local Pet = {}

function Pet:new(name, spawnrate, width, height, image_idle, image_pet, price, placementType, object)    
    object = object or {
		name= name,
		spawnrate = spawnrate,
        width = width,
        height = height,
		image_idle = image_idle,
		image_pet = image_pet or image_idle,
		price = price or 0,
        placementType = placementType or "summon",
		isPetted = false,
        visible = true
    }
    setmetatable(object, self)
    self.__index = self
    table.insert(globalMouseCallbacks, object)
    return object
end

function Pet:start()
    if self.visible ~= true then return end
    if self.isPetted == true then
        self.image_pet.loop = true
        self.image_pet:start()
    else
        self.image_idle.loop = true
        self.image_idle:start()
    end
end

function Pet:stop()
    if self.visible ~= true then return end
    if self.isPetted == true then
        self.image_pet:stop()
    else
        self.image_idle:stop()
    end
end

function Pet:draw(x, y)
    if self.visible ~= true then return end
    if self.isPetted == true then
        self.image_pet:draw(x or self.slot.x, y or self.slot.y)
    else
        self.image_idle:draw(x or self.slot.x, y or self.slot.y)
    end
end

function Pet:mousemoved(x, y, dx, dy, istouch)

end

function Pet:mousepressed(x, y, button)

end

return Pet
