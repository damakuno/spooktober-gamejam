local Pet = {}

function Pet:new(name, spawnrate, width, height, image_idle, image_pet, idle_duration, pet_duration, price)    
    object = object or {
		name= name,
		spawnrate = spawnrate,
        width = width,
        height = height,
		image_idle = image_idle,
		image_pet = image_pet or image_idle,
		idle_duration = idle_duration,
		pet_duration = pet_duration or idle_duration,
		price = price or 0,
		isPetted = false,
        visible = true
    }
    setmetatable(object, self)
    self.__index = self
    table.insert(globalMouseCallbacks, object)
    return object
end

function Pet:draw(x, y)
    if self.visible ~= true then return end
    if self.isPetted == true then
        self.image_pet:draw(x or self.slot.x, y or self.slot.y)
    else
        self.image_idle:draw(x or self.slot.x, y or self.slot.y)
    end
end

return Pet
