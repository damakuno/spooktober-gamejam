SceneHandler = require "lib.utils.SceneHandler"
Timer = require "lib.utils.Timer"
Anime = require "lib.utils.Anime"
Button = require "lib.utils.Button"

globalUpdates = {}

sh = SceneHandler:new(1)

button1 = Button:new(900, 400, 200, 200)
button1_pressed = "button 1 not pressed"

mouse = {x = 0, y = 0, dx = 0, dy = 0, pressed = false}

function love.load()
    love.window.setMode(1344, 768)
    -- load assets (sounds, images)
    -- hero = Anime:new("hero", love.graphics.newImage("res/images/oldHero.png"), 16, 18, 1, 1, true, true)    
    sh:curScene().load()
end

function love.draw()
    -- hero:draw(20, 20, 0, 4, 4)
    sh:curScene().draw()
    love.graphics.print("x: " .. mouse.x .. " y: " .. mouse.y, 20, 20)
    love.graphics.print(button1_pressed, 20, 40)
    love.graphics.rectangle("line", 900, 400, 200, 200)
end

function love.update(dt)
    -- hero:update(dt)
    sh:curScene().update(dt)
    -- timer1:update(dt)
    for i, obj in ipairs(globalUpdates) do 		
		obj:update(dt) 		
	end
end

function love.keyreleased(key)
    if sh:curScene().keyreleased ~= nil then sh:curScene().keyreleased(key) end

    if key == "rctrl" then debug.debug() end
end

function love.mousemoved(x, y, dx, dy, istouch)
    mouse.x = x
    mouse.y = y
    mouse.dx = dx
    mouse.dy = dy
end

function love.mousepressed(x, y, button)
    if button == 1 then
        mouse.pressed = true
        if button1:isWithin(x, y) then
            button1_pressed = "button 1 pressed"
        else
            button1_pressed = "button 1 not pressed"
        end
    end
end

function updates(dt, ...)
    local args = {...}
    for i, arg in ipairs(args) do arg:update(dt) end
end

function draws(...)
    local args = {...}
    for i, arg in ipairs(args) do arg:draw() end
end
