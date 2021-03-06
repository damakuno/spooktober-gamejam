SceneHandler = require "lib.utils.SceneHandler"
Timer = require "lib.utils.Timer"
Anime = require "lib.utils.Anime"
Button = require "lib.utils.Button"
LIP = require "lib.utils.LIP"
Slot = require "lib.core.Slot"
Pet = require "lib.core.Pet"
Shop = require "lib.core.Shop"
Window = require "lib.core.Window"
Spawner = require "lib.core.Spawner"
Child = require "lib.core.Child"

globalUpdates = {}
globalMouseCallbacks = {}

sh = SceneHandler:new()

mouse = {x = 0, y = 0, dx = 0, dy = 0, pressed = false}

function love.load()
    love.window.setMode(1344, 768)
    settings = LIP.load('config/Settings.ini')
    sfx = {
       coin = love.audio.newSource("res/audio/coin.wav", "static")
    } 
    music = {
        bgm = love.audio.newSource("res/audio/bgm.mp3", "stream")        
    }
    sfx.coin:setVolume(settings.Sound.sfx_volume)
    music.bgm:setLooping(true)
    music.bgm:play()
    music.bgm:setVolume(settings.Sound.music_volume)
    font = love.graphics.newFont("res/fonts/chuck_buck.ttf", 40)
    shop_font = love.graphics.newFont("res/fonts/chuck_buck.ttf", 24)
    -- load assets (sounds, images)
    -- hero = Anime:new("hero", love.graphics.newImage("res/images/oldHero.png"), 16, 18, 1, 1, true, true)    
    sh:setScene(1)
end

function love.draw()
    -- hero:draw(20, 20, 0, 4, 4)
    sh:curScene().draw()
end

function love.update(dt)
    -- hero:update(dt)
    sh:curScene().update(dt)
    -- timer1:update(dt)
    for i, obj in ipairs(globalUpdates) do
        if obj ~= nil then obj:update(dt) end
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
    for i, obj in ipairs(globalMouseCallbacks) do
        if obj ~= nil and obj.mousemoved ~=nil then obj:mousemoved(x, y, dx, dy, istouch) end
    end
end

function love.mousepressed(x, y, button)
    if sh:curScene().mousepressed ~= nil then
        sh:curScene().mousepressed(x, y, button)
    end
    for i, obj in ipairs(globalMouseCallbacks) do
        if obj ~= nil and obj.mousepressed ~=nil then obj:mousepressed(x, y, button) end
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

function randomInt(min, max)
    return math.floor(math.random() * (max - min) + min)
end