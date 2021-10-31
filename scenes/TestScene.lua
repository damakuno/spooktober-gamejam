local Scene = {
    load = function()  
        font = love.graphics.newFont("res/fonts/chuck_buck.ttf", 40)
        shop_font = love.graphics.newFont("res/fonts/chuck_buck.ttf", 12)
        SoulPoints = 1000
        status = "none"

        Children = {}

        for k,v in pairs(LIP.load('config/Children.ini')) do            
            Children[v.name] = Child:new(v.x, v.y, v.width, v.height, v.duration, 
            Anime:new(v.name.."_img", love.graphics.newImage(v.image), v.width, v.height, 1),
            Anime:new(v.name.."_img_dead", love.graphics.newImage(v.image_dead), v.width, v.height, v.duration), v.ticks)
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
                Spawners[v.name] = Spawner:new(v.x, v.y, v.ticks, PetSlots)
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

        DecorWindows = {}
        DecorShopButtons = {}
        --Decor shop layout
        for k, v in pairs(LIP.load('config/DecorShopLayout.ini')) do
            if v.type == 'Shop' then
                DecorWindows[v.name] = Shop:new(v.x, v.y, v.widht, v.height, Anime:new("shop_img", love.graphics.newImage(v.image)))
                DecorWindows[v.name].visible = false
            end
            if v.type == 'Button' then
                DecorShopButtons[v.name] = Button:new(v.x, v.y, v.width, v.height, 
                Anime:new(v.name.."_img", love.graphics.newImage(v.image)),
                Anime:new(v.name.."_img", love.graphics.newImage(v.imageHover))
            )
            DecorShopButtons[v.name].visible = false
            DecorShopButtons[v.name].onclick = function()
                if SoulPoints - Pets[v.pet].price > -1 then
                    SoulPoints = SoulPoints - Pets[v.pet].price
                    SelectedPet = Pets[v.pet]
                    toggleDecorShop()
                    toggleSlots()
                end
            end
            end
        end

        Buttons.DecorButton.onclick = function()
            status = "Decor Button Clicked"
            toggleDecorShop()
        end

        function toggleDecorShop()
            DecorWindows.DecorShop.visible = not DecorWindows.DecorShop.visible
            for _, button in pairs(DecorShopButtons) do
                if button.visible == true then button.visible = false 
                elseif button.visible == false then button.visible = true end       
            end
        end

        function toggleSlots()            
            for _, slot in pairs(PetSlots) do                
                if slot.button.visible == true then
                    slot.button.visible = false 
                    -- Buttons.SummonButton.visible = true
                elseif slot.button.visible == false then
                    if SelectedPet ~= nil then
                        -- Buttons.SummonButton.visible = false
                        -- status = "slot.placementType: "..slot.placementType.." SelectedPet.placementType: "..SelectedPet.placementType
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
        for _, child in pairs(Spawners.childSpawner.children) do            
            if child~= nil then child:draw() end
        end 
        for _, window in pairs(Windows) do
            if window ~= nil then window:draw() end
        end
        for _, button in pairs(ShopButtons) do            
            if button ~= nil then button:draw() end
        end
        for _, window in pairs(DecorWindows) do
            if window ~= nil then window:draw() end
        end
        for _, button in pairs(DecorShopButtons) do            
            if button ~= nil then button:draw() end
        end

        --draw text
        love.graphics.print("DECOR", font, 60, 360)
        love.graphics.print("PETS", font, 70, 590)
        love.graphics.print("SOULS: "..SoulPoints, font, 1000, 20)

        if SelectedPet~= nil then
            local ox = mouse.x - (SelectedPet.image_idle.width / 2)
            local oy = mouse.y - (SelectedPet.image_idle.height / 2)
            if SelectedPet.placementType == "hanging" then
                ox = mouse.x - (SelectedPet.image_idle.width / 2)
                oy = mouse.y
            end
            SelectedPet.image_idle:draw(ox, oy)
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
            Spawners.childSpawner:spawn(Children.GhostChild)
        end
    end,
    mousepressed = function(x, y, button) end
}

return Scene
