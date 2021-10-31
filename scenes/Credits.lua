local Scene = {
	load = function()	
	-- see if the file exists
	music.bgm:setVolume(0.2)
	function file_exists(file)
		local f = io.open(file, "rb")
		if f then f:close() end
		return f ~= nil
	end	
	-- get all lines from a file, returns an empty 
	-- list/table if the file does not exist
	function lines_from(file)
		if not file_exists(file) then return {} end
		lines = {}
		for line in io.lines(file) do 
		lines[#lines + 1] = line
		end
		return lines
	end

	lines = lines_from("res/credits.txt")

	pos = {
		x = 0,
		y = 0
	}
	end,
	draw = function()
		love.graphics.setBackgroundColor(40 / 255, 40 / 255, 40 / 255)
		for i, v in ipairs(lines) do
			local oy = pos.y + (40 * i)			
			love.graphics.printf(v, font, pos.x, oy, 1366, "center")
		end
	end,
	update = function(dt)

	end
}

return Scene