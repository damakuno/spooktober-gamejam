local Scene = {
    load = function()                
        SoulPoints = 1000
        status = "none"
        Pets = {}

        for k, v in pairs(LIP.load('config/Pets.ini')) do
            Pets[v.name] = Pet:new(v.name, v.spawnrate, v.width, v.height, 
            Anime:new("image_idle"..v.name, love.graphics.newImage(v.image_idle), v.width, v.height, v.idle_duration),
            Anime:new("image_pet"..v.name, love.graphics.newImage(v.image_pet), v.width, v.height, v.pet_duration), 
            v.price)
        end
        
        SelectedPet = nil

        PetSlots = {}
        
        Buttons = {}                
        -- loading main layout
        for k, v in pairs(LIP.load('config/MainLayout.ini')) do                
            if v.type == 'Slot' then                               
                PetSlots[v.name] = Slot:new(v.name, v.x, v.y, v.width, v.height,
                        Anime:new("slot_img", love.graphics.newImage(v.image)),
                        Anime:new("slot_hover_img", love.graphics.newImage(v.imageHover))
                    )                
            end
            if v.type == 'Button' then
                Buttons[v.name] = Button:new(v.x, v.y, v.width, v.height, 
                Anime:new(v.name.."_img", love.graphics.newImage(v.image)),
                Anime:new(v.name.."_img", love.graphics.newImage(v.imageHover))
            )
            end
        end

        Windows = {}
        ShopButtons = {}
        --shop layout
        for k, v in pairs(LIP.load('config/ShopLayout.ini')) do
            if v.type == 'Shop' then
                Windows[v.name] = Shop:new(v.x, v.y, v.widht, v.height, Anime:new("shop_img", love.graphics.newImage(v.image)))
                Windows[v.name].visible = false
            end
            if v.type == 'Button' then
                ShopButtons[v.name] = Button:new(v.x, v.y, v.width, v.height, 
                Anime:new(v.name.."_img", love.graphics.newImage(v.image)),
                Anime:new(v.name.."_img", love.graphics.newImage(v.imageHover))
            )
            ShopButtons[v.name].visible = false
            ShopButtons[v.name].onclick = function()
                if SoulPoints - Pets[v.pet].price > -1 then
                    SoulPoints = SoulPoints - Pets[v.pet].price
                    SelectedPet = Pets[v.pet]
                    toggleShop()
                end
            end
            end
        end

        Buttons.SummonButton.onclick = function()
            status = "Summon Button Clicked"
            toggleShop()
        end

        function toggleShop()
            Windows.Shop.visible = not Windows.Shop.visible
            for _, button in pairs(ShopButtons) do
                if button.visible == true then button.visible = false 
                elseif button.visible == false then button.visible = true end                
            end
            for _, slot in pairs(PetSlots) do
                if slot.button.visible == true then slot.button.visible = false 
                elseif slot.button.visible == false then slot.button.visible = true end                
            end
        end
    end,
    draw = function()
        love.graphics.setBackgroundColor(0 / 255, 0 / 255, 0 / 255)
        love.graphics.print("x: " .. mouse.x .. " y: " .. mouse.y, 20, 20)
        love.graphics.print(status, 20, 40)
        love.graphics.print("Soul Points: "..SoulPoints, 20, 60)
        for _, slot in pairs(PetSlots) do
            if slot ~=nil then slot:draw() end
        end
        for _, button in pairs(Buttons) do
            if button ~=nil then button:draw() end
        end
        for _, window in pairs(Windows) do
            if window ~= nil then window:draw() end
        end
        for _, button in pairs(ShopButtons) do
            if button ~= nil then button:draw() end
        end
    end,
    update = function(dt) end,
    keyreleased = function(key) 
        if key == "s" then
            for _, slot in pairs(PetSlots) do                
                slot.button.visible = not slot.button.visible                
            end
        end
        if key == "r" then
            SoulPoints = 1000
        end
        -- if key == "b" then
        --     SelectedPetIndex = SelectedPetIndex - 1
        --     SelectedPet = Pets[SelectedPetIndex]   
        --     if SelectedPet == nil then SelectedPetIndex = SelectedPetIndex + 1 end
        --     SelectedPet = Pets[SelectedPetIndex]   
        --     if SelectedPet ~= nil then                             
        --         status = "SelectedPetIndex: "..SelectedPetIndex.." PetName: "..SelectedPet.name
        --     end
        -- end
        -- if key == "n" then
        --     SelectedPetIndex = SelectedPetIndex + 1
        --     SelectedPet = Pets[SelectedPetIndex]
        --     if SelectedPet == nil then SelectedPetIndex = SelectedPetIndex - 1  end
        --     SelectedPet = Pets[SelectedPetIndex]
        --     if SelectedPet ~= nil then                
        --         status = "SelectedPetIndex: "..SelectedPetIndex.." PetName: "..SelectedPet.name
        --     end
        -- end
    end,
    mousepressed = function(x, y, button) end
}

return Scene
