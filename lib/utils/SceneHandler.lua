local MainScene = require "scenes.MainScene"
local Credits = require "scenes.Credits" 
local TestScene = require "scenes.TestScene" 
local SceneHandler = {}

function SceneHandler:new(sceneIndex, object)
    object = object or
	{
		Scenes = {
			[1] = MainScene, 
			[2] = Credits,
			[99] = TestScene
		},
		SceneIndex = 1 or sceneIndex
	}
    setmetatable(object, self)
    self.__index = self
    return object
end

function SceneHandler:setScene(numIndex) 
	self.SceneIndex = numIndex
	self.Scenes[self.SceneIndex].load()
end

function SceneHandler:curScene()
	return self.Scenes[self.SceneIndex]
end

return SceneHandler
