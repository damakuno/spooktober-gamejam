local Scene = {
    load = function()                
        status = "none"
        Pets = {}        

        for k, v in pairs(LIP.load('config/Pets.ini')) do
            Pets[#Pets+1] = Pet:new(v.name, v.spawnrate, v.width, v.height, 
            Anime:new("image_idle"..v.name, love.graphics.newImage(v.image_idle), v.width, v.height, v.idle_duration),
            Anime:new("image_pet"..v.name, love.graphics.newImage(v.image_pet), v.width, v.height, v.pet_duration), 
            v.price)
        end

        SelectedPetIndex = 1
        SelectedPet = Pets[SelectedPetIndex]

        PetSlots = {}        
        

        for k, v in pairs(LIP.load('config/MainLayout.ini')) do                
            if v.type == 'Slot' then                               
                PetSlots[#PetSlots+1] = Slot:new(v.name, v.x, v.y, v.width, v.height,
                        Anime:new("slot_img", love.graphics.newImage(v.image)),
                        Anime:new("slot_hover_img", love.graphics.newImage(v.imageHover))
                    )
                
            end        
        end
    end,
    draw = function()
        love.graphics.setBackgroundColor(0 / 255, 0 / 255, 0 / 255)
        love.graphics.print("x: " .. mouse.x .. " y: " .. mouse.y, 20, 20)
        love.graphics.print(status, 20, 40)
        for _, slot in pairs(PetSlots) do
            if slot ~=nil then slot:draw() end
        end
    end,
    update = function(dt) end,
    keyreleased = function(key) 
        if key == "s" then
            for _, slot in pairs(PetSlots) do                
                slot.button.visible = not slot.button.visible                
            end
        end
        if key == "b" then
            SelectedPetIndex = SelectedPetIndex - 1
            SelectedPet = Pets[SelectedPetIndex]   
            if SelectedPet == nil then SelectedPetIndex = SelectedPetIndex + 1 end
            if SelectedPet ~= nil then                             
                status = "SelectedPetIndex: "..SelectedPetIndex.." PetName: "..SelectedPet.name
            end
        end
        if key == "n" then
            SelectedPetIndex = SelectedPetIndex + 1
            SelectedPet = Pets[SelectedPetIndex]
            if SelectedPet == nil then SelectedPetIndex = SelectedPetIndex - 1 end
            if SelectedPet ~= nil then                
                status = "SelectedPetIndex: "..SelectedPetIndex.." PetName: "..SelectedPet.name
            end
        end
    end,
    mousepressed = function(x, y, button) end
}

return Scene
