local Scene = {
    load = function()                
        status = "none"
        -- TODO: replace anime with Pet objects in PetSlots
        -- PetSlots = {[1] = nil, [2] = nil, [3] = nil, [4] = nil}
        PetSlots = {}        
        
        for k, v in pairs(LIP.load('config/MainLayout.ini')) do                
            if v.type == 'Slot' then               
                print ("v.name: "..v.name.." v.x: "..v.x)
                PetSlots[#PetSlots+1] = Slot:new(v.name, v.x, v.y, v.width, v.height,
                        Anime:new("slot_img", love.graphics.newImage(v.image)),
                        Anime:new("slot_hover_img", love.graphics.newImage(v.imageHover))
                    )
                
            end        
        end

        -- cat_img = Anime:new("cat", love.graphics.newImage("res/images/cat.png"))
        -- slot_img = Anime:new("slot_img",
        --                      love.graphics.newImage("res/images/pp.png"))
        -- slot_img_hover = Anime:new("slot_hover_img", love.graphics
        --                                .newImage("res/images/pp_hover.png"))

        -- slot1 = Button:new(900, 400, 200, 200, slot_img, slot_img_hover)
        -- slot1.onclick = function()
        --     status = "callback click triggered"
		-- 	PetSlots[1] = cat_img
        -- end

		-- slot2 = Button:new(500, 400, 200, 200, slot_img, slot_img_hover)
        -- slot2.onclick = function()            
		-- 	PetSlots[2] = cat_img
        -- end
    end,
    draw = function()
        love.graphics.setBackgroundColor(0 / 255, 0 / 255, 0 / 255)
        love.graphics.print("x: " .. mouse.x .. " y: " .. mouse.y, 20, 20)
        love.graphics.print(status, 20, 40)
        for _, slot in pairs(PetSlots) do
            if slot ~=nil then slot:draw() end
        end
        -- if PetSlots[1] ~= nil then PetSlots[1]:draw() end
        -- slot1:draw()
		-- slot2:draw()
		-- if PetSlots[1] ~= nil then
		-- 	cat_img:draw(900, 400)
		-- end
		
		-- if PetSlots[2] ~= nil then
		-- 	cat_img:draw(500, 400)
		-- end
        -- love.graphics.rectangle("line", 900, 400, 200, 200)
    end,
    update = function(dt) end,
    keyreleased = function(key) 
        if key == "s" then
            for _, slot in pairs(PetSlots) do
                print(slot.name)
            end
        end
    end,
    mousepressed = function(x, y, button) end
}

return Scene
