local Scene = {
    load = function()                
        SoulPoints = 1000
        status = "none"

        Children = {}

        for k,v in pairs(LIP.load('config/Children.ini')) do            
            Children[v.name] = Child:new(v.x, v.y, v.width, v.height, v.duration, 
            Anime:new(v.name.."_img", love.graphics.newImage(v.image), v.width, v.height, v.duration), v.ticks)
        end

        Pets = {}

        for k, v in pairs(LIP.load('config/Pets.ini')) do
            Pets[v.name] = Pet:new(v.name, v.spawnrate, v.width, v.height, 
            Anime:new("image_idle"..v.name, love.graphics.newImage(v.image_idle), v.width, v.height, v.idle_duration),
            Anime:new("image_pet"..v.name, love.graphics.newImage(v.image_pet), v.width, v.height, v.pet_duration), 
            v.price, v.placementType)
        end
        
        SelectedPet = nil

        BGWindows = {}

        PetSlots = {}
        
        -- childSpawner = Spawner:new(0, 0, 1, PetSlots)

        Buttons = {}                

        Spawners = {}
        -- loading main layout
        for k, v in pairs(LIP.load('config/MainLayout.ini')) do     
            if v.type == 'Window' then
                BGWindows[v.name] = Window:new(v.x, v.y, v.width, v.height,
                Anime:new(v.name.."_img", love.graphics.newImage(v.image)))
            end           
            if v.type == 'Slot' then                               
                PetSlots[v.name] = Slot:new(v.name, v.x, v.y, v.width, v.height,
                        Anime:new("slot_img", love.graphics.newImage(v.image)),
                        Anime:new("slot_hover_img", love.graphics.newImage(v.imageHover)),
                        Anime:new("slot_hover_img", love.graphics.newImage(v.bgImage)),
                        v.placementType
                    )  
                PetSlots[v.name].button.visible = false              
            end
            if v.type == 'Button' then
                Buttons[v.name] = Button:new(v.x, v.y, v.width, v.height, 
                Anime:new(v.name.."_img", love.graphics.newImage(v.image)),
                Anime:new(v.name.."_img", love.graphics.newImage(v.imageHover))
            )
            end
            if v.type == 'Spawner' then
                Spawners[v.name] = Spawner:new(v.x, v.y, v.ticks, Children.GhostChild, PetSlots)
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
                    toggleSlots()
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
        end

        function toggleSlots()            
            for _, slot in pairs(PetSlots) do                
                if slot.button.visible == true then
                    slot.button.visible = false 
                    Buttons.SummonButton.visible = true
                elseif slot.button.visible == false then
                    if SelectedPet ~= nil then
                        Buttons.SummonButton.visible = false
                        if slot.placementType == SelectedPet.placementType then
                            slot.button.visible = true
                        end                
                    end
                end
            end
        end
    end,
    draw = function()
        for _, bg in pairs(BGWindows) do            
            if bg ~= nil then bg:draw() end
        end

        love.graphics.setBackgroundColor(0 / 255, 0 / 255, 0 / 255)
        love.graphics.print("x: " .. mouse.x .. " y: " .. mouse.y, 230, 10)
        love.graphics.print(status, 230, 30)
        love.graphics.print("Soul Points: "..SoulPoints, 230, 50)
        if Spawners["childSpawner"] ~= nil then
            love.graphics.print("Spawn Rate: "..Spawners["childSpawner"].totalSpawnRate, 230, 70)        
        end
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
        for _, child in pairs(Spawners.childSpawner.children) do            
            if child~= nil then child:draw() end
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
        if key == "f" then
            Spawners.childSpawner:spawn()
        end
    end,
    mousepressed = function(x, y, button) end
}

return Scene
