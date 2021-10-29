local Slot = {}

function Slot:new(name, x, y, width, height, image, imageHover, object)
    object = object or {
        name = name,
        x = x,
        y = y,
        width = width,
        height = height,
        image = image,
        imageHover = imageHover,
		button = Button:new(x, y, width, height, image, imageHover),
		pet = nil
    }

	object.button.onclick = function()
		status = object.name.." clicked"
		if SelectedPet ~= nil then
			object:assignPet(SelectedPet)
		end
	end
	
    setmetatable(object, self)	
    self.__index = self
    return object
end

function Slot:assignPet(pet)
	self.pet = pet
	pet.slot = self
end

function Slot:draw() 
	self.button:draw()
	if self.pet ~= nil then 
		self.pet:draw(self.x, self.y)
	end
end

return Slot
