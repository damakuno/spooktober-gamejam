local Scene = {
    load = function()
        PetSlots = {[1] = nil, [2] = nil, [3] = nil, [4] = nil}
        cat_img = Anime:new("cat", love.graphics.newImage("res/images/cat.png"))
        slot_img = Anime:new("slot_img",
                             love.graphics.newImage("res/images/pp.png"))
        slot_img_hover = Anime:new("slot_hover_img", love.graphics
                                       .newImage("res/images/pp_hover.png"))

        slot1 = Button:new(900, 400, 200, 200, slot_img, slot_img_hover)
        slot1.onclick = function()
            slot_status = "callback click triggered"
			PetSlots[1] = cat_img
        end
        slot_status = "none"

		slot2 = Button:new(500, 400, 200, 200, slot_img, slot_img_hover)
        slot2.onclick = function()            
			PetSlots[2] = cat_img
        end
    end,
    draw = function()
        love.graphics.setBackgroundColor(0 / 255, 0 / 255, 0 / 255)
        love.graphics.print("x: " .. mouse.x .. " y: " .. mouse.y, 20, 20)
        love.graphics.print(slot_status, 20, 40)
        slot1:draw()
		slot2:draw()
		if PetSlots[1] ~= nil then
			cat_img:draw(900, 400)
		end
		
		if PetSlots[2] ~= nil then
			cat_img:draw(500, 400)
		end
        -- love.graphics.rectangle("line", 900, 400, 200, 200)
    end,
    update = function(dt) end,
    keyreleased = function(key) end,
    mousepressed = function(x, y, button) end
}

return Scene
