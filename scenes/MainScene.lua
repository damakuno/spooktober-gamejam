local Scene = {
	load = function() 

	end,
	draw = function()
		love.graphics.setBackgroundColor(0 / 255, 0 / 255, 0 / 255)
	end,
	update = function(dt)

	end,
	keyreleased = function(key)
		if key == "s" then
			print("s pressed")
		end
	end
}

return Scene