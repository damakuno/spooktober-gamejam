local Slot = {}

function Slot:new(name, x, y, width, height, image, imageHover, bgImage, placementType, object)
    object = object or {
        name = name,
        x = x,
        y = y,
        width = width,
        height = height,
        image = image,
        imageHover = imageHover,
		button = Button:new(x, y, width, height, image, imageHover),
		pet = nil,
		bgImage = bgImage,		
		placementType = placementType or "summon"
    }

	object.button.onclick = function()
		status = object.name.." clicked"
		if SelectedPet ~= nil then
			object:assignPet(SelectedPet)
			SelectedPet = nil
			toggleSlots()
		end
	end

    setmetatable(object, self)	
    self.__index = self
    return object
end

function Slot:assignPet(pet)
	-- TODO: check placementType before assigning, or even showing the slot in the first place
	if pet.placementType == self.placementType then
		self.pet = Pet:new(pet.name, pet.spawnrate, pet.width, pet.height, pet.image_idle, pet.image_pet, pet.price)
		self.pet:start()
	end
	pet.slot = self
end

function Slot:draw() 
	-- TODO: check placementType before assigning, or even showing the slot in the first place
	self.bgImage:draw(self.x, self.y)
	self.button:draw()
	if self.pet ~= nil then 
		self.pet:draw(self.x, self.y)
	end
end

return Slot
